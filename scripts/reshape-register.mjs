// `npm run register:reshape` — give the College's register the shape the
// librarians asked for, once, from this machine.
//
//     node scripts/reshape-register.mjs            a dry run: reads, checks, prints
//     node scripts/reshape-register.mjs --apply    writes
//     node scripts/reshape-register.mjs --apply --only=signouts|restricted|index
//
// WHAT IT DOES. Three things to the sheet the Worker only ever reads:
//
//   1. `Library_Signouts` gets a `Date` column, its `Returned?` checkbox
//      becomes a `Status` dropdown (Out / Returned), rows still out are tinted,
//      and a row whose signout took the last copy off the shelf is tinted the
//      red `Borrowed_Books` already uses for Overdue.
//   2. `Restricted Titles`' Availability column becomes a formula.
//   3. `Book_Index`'s Availability column becomes the same formula: Out when
//      Copies less the open loans on both tabs reaches zero.
//
// WHY A SCRIPT AND NOT THE WORKER. The archive derives availability from the
// loan rows on every read (functions/lib/availability.ts) and could write the
// answer back — but that means a write scope on a service account that serves
// the public, a schedule, and a column that lags the sheet by the schedule. A
// formula is live the instant a librarian ticks a box, and the account the
// Worker runs with stays read-only. So the formula is written once, from here,
// with a scope the Worker is never given.
//
// IDEMPOTENT. Every phase looks before it writes and skips what is already
// done, so a re-run after a refusal or a half-finished apply is safe. The
// signouts reshape is one batchUpdate, which Sheets applies atomically: it
// happens whole or not at all. The real undo is Google's version history,
// which the sheet's owner can restore from; a JSON dump of the four tabs is
// also written before the first write, so the pre-state is on disk.
//
// THE WORKER MUST BE DEPLOYED FIRST. Until `availability.ts` finds its columns
// by header, inserting a column into `Library_Signouts` turns every signout
// ever recorded into an open loan. That change is in the history before this
// script; do not run this against a Worker older than it.
//
// EXACT MATCH, DELIBERATELY. COUNTIFS pairs a loan with a title by exact
// spelling (case aside), where the Worker forgives punctuation and articles.
// The dropdowns on both loan tabs feed exact index titles now; the handful of
// open rows written before the dropdown are respelled here, from a unique
// match under the Worker's own normaliser, and reported. Closed rows never
// affect a count and are left as written.

import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { createSign } from 'node:crypto';
import { fileURLToPath } from 'node:url';
import { normaliseTitle } from '../shared/titles.ts';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const SCOPE = 'https://www.googleapis.com/auth/spreadsheets';
const API = 'https://sheets.googleapis.com/v4/spreadsheets';

/** The tabs, by the ids the sheet gave them. A rename does not move these. */
const TABS = {
  index: { id: 680868932, title: 'Book_Index' },
  restricted: { id: 1864110927, title: 'Restricted Titles' },
  borrowed: { id: 161886184, title: 'Borrowed_Books' },
  signouts: { id: 754105997, title: 'Library_Signouts' },
};

/**
 * Availability, as the sheet will work it out.
 *
 * `"<>Returned"` counts a blank status as out, which is what the Worker does
 * for a signout too — but only on rows whose book matches, so the blank tail
 * of the grid, the `Old Entries` divider and the header never count.
 */
const availability = (row) =>
  `=IF($A${row}="","",IF($C${row}` +
  `-COUNTIFS(Borrowed_Books!$A:$A,$A${row},Borrowed_Books!$F:$F,"Out")` +
  `-COUNTIFS(Borrowed_Books!$A:$A,$A${row},Borrowed_Books!$F:$F,"Overdue")` +
  `-COUNTIFS(Library_Signouts!$A:$A,$A${row},Library_Signouts!$E:$E,"<>Returned")` +
  `<=0,"Out","In"))`;

/**
 * Rows still out, and rows whose signout emptied the shelf. Relative to A2.
 *
 * A conditional format may not name another tab outright — Sheets refuses the
 * rule — so the two lookups go through INDIRECT, which it allows.
 */
const STILL_OUT = '=AND($A2<>"",$E2<>"Returned")';
const LAST_COPY =
  '=AND($A2<>"",$E2<>"Returned",IFERROR(VLOOKUP($A2,INDIRECT("Book_Index!$A:$D"),4,FALSE),' +
  'IFERROR(VLOOKUP($A2,INDIRECT("\'Restricted Titles\'!$A:$E"),5,FALSE),""))="Out")';

const MILD = { backgroundColor: { red: 1, green: 0.95, blue: 0.8 } };
const STRONG_DEFAULT = {
  backgroundColor: { red: 0.6 },
  textFormat: { foregroundColor: { red: 1, green: 1, blue: 1 } },
};

/* -- arguments -------------------------------------------------------------- */

const args = process.argv.slice(2);
const APPLY = args.includes('--apply');
const ONLY = args.find((a) => a.startsWith('--only='))?.slice('--only='.length) ?? null;
const BACKUP =
  args.find((a) => a.startsWith('--backup='))?.slice('--backup='.length) ??
  path.join(os.tmpdir(), `arcanaeum-register-${new Date().toISOString().replace(/[:.]/g, '-')}.json`);

if (ONLY !== null && !['signouts', 'restricted', 'index'].includes(ONLY)) {
  console.error(`\n  --only takes signouts, restricted or index; not ${ONLY}\n`);
  process.exit(1);
}

/* -- the credential --------------------------------------------------------- */

/** `.dev.vars`, the way wrangler reads it: the first `=` splits key from value. */
function devVars() {
  const file = path.join(ROOT, '.dev.vars');
  if (!fs.existsSync(file)) {
    console.error('\n  No .dev.vars. Run `npm run dev:vars` first.\n');
    process.exit(1);
  }
  const vars = {};
  for (const line of fs.readFileSync(file, 'utf8').split(/\r?\n/)) {
    const at = line.indexOf('=');
    if (at > 0) vars[line.slice(0, at).trim()] = line.slice(at + 1).trim();
  }
  return vars;
}

async function accessToken(account) {
  const b64 = (s) => Buffer.from(s).toString('base64url');
  const now = Math.floor(Date.now() / 1000);
  const header = b64(JSON.stringify({ alg: 'RS256', typ: 'JWT' }));
  const claims = b64(
    JSON.stringify({
      iss: account.client_email,
      scope: SCOPE,
      aud: account.token_uri,
      iat: now,
      exp: now + 3600,
    }),
  );
  const signature = createSign('RSA-SHA256')
    .update(`${header}.${claims}`)
    .sign(account.private_key, 'base64url');
  const res = await fetch(account.token_uri, {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body:
      `grant_type=${encodeURIComponent('urn:ietf:params:oauth:grant-type:jwt-bearer')}` +
      `&assertion=${header}.${claims}.${signature}`,
  });
  const data = await res.json();
  if (!res.ok || !data.access_token) throw new Error(`token exchange failed (${res.status})`);
  return data.access_token;
}

/* -- the API ---------------------------------------------------------------- */

const vars = devVars();
const sheetId = vars.ARCANAEUM_SHEET_ID;
const account = JSON.parse((vars.GOOGLE_SERVICE_ACCOUNT_JSON ?? '').replace(/^﻿/, '') || '{}');
if (!sheetId || !account.client_email) {
  console.error('\n  .dev.vars has no ARCANAEUM_SHEET_ID or GOOGLE_SERVICE_ACCOUNT_JSON.\n');
  process.exit(1);
}
const auth = { authorization: `Bearer ${await accessToken(account)}` };

class SheetsError extends Error {
  constructor(status, message) {
    super(`${status}: ${message}`);
    this.status = status;
    this.detail = message;
  }
}

async function call(method, url, body) {
  const res = await fetch(url, {
    method,
    headers: { ...auth, 'content-type': 'application/json' },
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new SheetsError(res.status, data.error?.message ?? res.statusText);
  return data;
}

const get = (query) => call('GET', `${API}/${sheetId}${query}`);
const batchUpdate = (requests) => call('POST', `${API}/${sheetId}:batchUpdate`, { requests });
const writeValues = (data) =>
  call('POST', `${API}/${sheetId}/values:batchUpdate`, { valueInputOption: 'USER_ENTERED', data });

/* -- reading ---------------------------------------------------------------- */

const cellOf = (rows, r, c) => (rows[r]?.[c] ?? '').toString();
const trimmed = (v) => v.toString().trim();
const quoted = (title) => `'${title.replace(/'/g, "''")}'`;

async function readState() {
  const meta = await get(
    '?fields=properties(title,locale),sheets(properties(sheetId,title,gridProperties),protectedRanges,conditionalFormats)',
  );
  const byId = Object.fromEntries((meta.sheets ?? []).map((s) => [s.properties.sheetId, s]));

  const ranges = [
    `${quoted(TABS.index.title)}!A1:I200`,
    `${quoted(TABS.restricted.title)}!A1:G60`,
    `${quoted(TABS.borrowed.title)}!A1:H400`,
    `${quoted(TABS.signouts.title)}!A1:F500`,
  ];
  const values = await get(
    `/values:batchGet?${ranges.map((r) => `ranges=${encodeURIComponent(r)}`).join('&')}`,
  );
  const [index, restricted, borrowed, signouts] = (values.valueRanges ?? []).map((r) => r.values ?? []);

  const formulas = await get(
    `/values:batchGet?valueRenderOption=FORMULA` +
      `&ranges=${encodeURIComponent(`${quoted(TABS.index.title)}!D1:D3`)}` +
      `&ranges=${encodeURIComponent(`${quoted(TABS.restricted.title)}!E1:E3`)}`,
  );
  const [indexD, restrictedE] = (formulas.valueRanges ?? []).map((r) => r.values ?? []);

  return { meta, byId, index, restricted, borrowed, signouts, indexD, restrictedE };
}

/** The restricted tab's title rows end where its second header begins. */
function restrictedTitleRows(restricted) {
  let n = 0;
  for (const [i, row] of restricted.entries()) {
    if (i === 0) continue;
    if (trimmed(row[1] ?? '').toLowerCase() === 'location') break;
    n = i;
  }
  return n; // zero-based index of the last title row
}

/* -- pre-flight ------------------------------------------------------------- */

function preflight(state) {
  const problems = [];
  const notes = [];

  for (const tab of Object.values(TABS)) {
    const sheet = state.byId[tab.id];
    if (!sheet) problems.push(`no tab with id ${tab.id} (${tab.title})`);
    else if (sheet.properties.title !== tab.title) {
      notes.push(`tab ${tab.id} is now called "${sheet.properties.title}", not "${tab.title}"`);
    }
  }
  const locale = state.meta.properties?.locale ?? '';
  if (!/^en(_|$)/.test(locale)) {
    problems.push(`spreadsheet locale is "${locale}"; the formulas are written for an en_* locale`);
  }

  const titles = [
    ...state.index.slice(1).map((r, i) => ['Book_Index', i + 2, r[0] ?? '']),
    ...state.restricted
      .slice(1, restrictedTitleRows(state.restricted) + 1)
      .map((r, i) => ['Restricted Titles', i + 2, r[0] ?? '']),
  ].filter(([, , t]) => trimmed(t) !== '');

  for (const [tab, row, t] of titles) {
    if (/[*?~]/.test(t) || /^[=<>]/.test(t)) problems.push(`${tab}!A${row} "${t}" would misread in COUNTIFS`);
    if (t !== trimmed(t)) {
      // The index's own spelling, spaces and all, is what its dropdowns hand
      // the loan tabs, so the count still pairs them. Worth a librarian's
      // minute all the same.
      notes.push(`${tab}!A${row} carries whitespace: ${JSON.stringify(t)} — a loan typed by hand will not match it`);
    }
  }
  const keys = new Map();
  for (const [tab, row, t] of titles) {
    const k = normaliseTitle(t);
    if (keys.has(k)) notes.push(`${tab}!A${row} "${t}" and ${keys.get(k)} share a normalised title`);
    else keys.set(k, `${tab}!A${row} "${t}"`);
  }

  const bStatus = new Set(state.borrowed.slice(2).map((r) => trimmed(r[5] ?? '')));
  for (const v of bStatus) {
    if (!['', 'Out', 'Overdue', 'Returned'].includes(v)) problems.push(`Borrowed_Books status "${v}" is not Out, Overdue or Returned`);
  }
  const reshaped = signoutsReshaped(state);
  const sCol = reshaped ? 4 : 3;
  const sStatus = new Set(state.signouts.slice(1).map((r) => trimmed(r[sCol] ?? '')));
  for (const v of sStatus) {
    if (!['', 'TRUE', 'FALSE', 'Out', 'Returned'].includes(v)) problems.push(`Library_Signouts status "${v}" is not TRUE, FALSE, Out or Returned`);
  }

  for (const sheet of state.meta.sheets ?? []) {
    for (const p of sheet.protectedRanges ?? []) {
      const r = p.range;
      const where =
        r.startRowIndex === undefined && r.startColumnIndex === undefined
          ? 'the whole tab'
          : `rows ${(r.startRowIndex ?? 0) + 1}–${r.endRowIndex ?? '∞'}, cols ${(r.startColumnIndex ?? 0) + 1}–${r.endColumnIndex ?? '∞'}`;
      notes.push(
        `protected: ${sheet.properties.title}, ${where}` +
          (p.warningOnly ? ' (warning only)' : '') +
          (p.editors ? `, editors ${JSON.stringify(p.editors)}` : ', editors not visible to this account'),
      );
    }
  }

  return { problems, notes };
}

/* -- phase S: Library_Signouts ---------------------------------------------- */

const signoutsReshaped = (state) =>
  trimmed(cellOf(state.signouts, 0, 2)) === 'Date' && trimmed(cellOf(state.signouts, 0, 4)) === 'Status';

/**
 * The open rows written before the dropdown, and the exact spelling each one
 * should carry. Only a unique match under the Worker's normaliser is offered.
 */
function legacyFixes(state, reshaped) {
  const exact = new Set();
  const byKey = new Map();
  // The index's exact bytes, because that is what COUNTIFS will be given.
  const consider = (t) => {
    const title = t.toString();
    if (trimmed(title) === '') return;
    exact.add(title.toLowerCase());
    const k = normaliseTitle(title);
    byKey.set(k, byKey.has(k) ? null : title);
  };
  for (const r of state.index.slice(1)) consider(r[0] ?? '');
  for (const r of state.restricted.slice(1, restrictedTitleRows(state.restricted) + 1)) consider(r[0] ?? '');

  const statusCol = reshaped ? 4 : 3;
  const fixes = [];
  const unmatched = [];
  for (const [i, r] of state.signouts.entries()) {
    if (i === 0) continue;
    const book = (r[0] ?? '').toString();
    if (trimmed(book) === '' || Number.isFinite(Number(book))) continue;
    const status = trimmed(r[statusCol] ?? '').toLowerCase();
    if (status === 'true' || status.startsWith('return')) continue;
    if (exact.has(book.toLowerCase())) continue;
    const to = byKey.get(normaliseTitle(book));
    if (to) fixes.push({ row: i + 1, from: book, to });
    else unmatched.push({ row: i + 1, from: book });
  }
  return { fixes, unmatched };
}

function signoutsRequests(state) {
  const sheet = state.byId[TABS.signouts.id];
  const rows = sheet.properties.gridProperties.rowCount;
  const id = TABS.signouts.id;

  // The Overdue red Borrowed_Books already wears, if it still has one.
  const overdue = (state.byId[TABS.borrowed.id]?.conditionalFormats ?? []).find((f) =>
    /overdue/i.test(f.booleanRule?.condition?.values?.[0]?.userEnteredValue ?? ''),
  );
  const strong = overdue?.booleanRule?.format ?? STRONG_DEFAULT;

  const datePattern =
    'm/d/yyyy'; // what the READ ME's LCTRL+; produces on Borrowed_Books

  // Status, from the pre-insert Returned? column (D, index 3).
  const status = [];
  for (let r = 1; r < rows; r++) {
    const book = trimmed(cellOf(state.signouts, r, 0));
    const was = trimmed(cellOf(state.signouts, r, 3));
    let cell = {};
    if (was.toLowerCase() === 'true') cell = { userEnteredValue: { stringValue: 'Returned' } };
    else if (book !== '' && !Number.isFinite(Number(book))) cell = { userEnteredValue: { stringValue: 'Out' } };
    else if (was === 'Out' || was === 'Returned') cell = { userEnteredValue: { stringValue: was } };
    status.push({ values: [cell] });
  }

  const { fixes } = legacyFixes(state, false);

  const existing = (sheet.conditionalFormats ?? []).map(
    (f) => f.booleanRule?.condition?.values?.[0]?.userEnteredValue,
  );
  const range = { sheetId: id, startRowIndex: 1, endRowIndex: rows, startColumnIndex: 0, endColumnIndex: 6 };
  const rule = (formula, format) => ({
    addConditionalFormatRule: {
      index: 0,
      rule: { ranges: [range], booleanRule: { condition: { type: 'CUSTOM_FORMULA', values: [{ userEnteredValue: formula }] }, format } },
    },
  });

  return [
    { insertDimension: { range: { sheetId: id, dimension: 'COLUMNS', startIndex: 2, endIndex: 3 }, inheritFromBefore: false } },
    {
      updateCells: {
        start: { sheetId: id, rowIndex: 0, columnIndex: 2 },
        rows: [{ values: [{ userEnteredValue: { stringValue: 'Date' }, note: 'Select the cell and press LCTRL+; to stamp today’s date.' }] }],
        fields: 'userEnteredValue,note',
      },
    },
    {
      updateCells: {
        start: { sheetId: id, rowIndex: 0, columnIndex: 4 },
        rows: [{ values: [{ userEnteredValue: { stringValue: 'Status' } }] }],
        fields: 'userEnteredValue',
      },
    },
    {
      repeatCell: {
        range: { sheetId: id, startRowIndex: 1, endRowIndex: rows, startColumnIndex: 2, endColumnIndex: 3 },
        cell: { userEnteredFormat: { numberFormat: { type: 'DATE', pattern: datePattern } } },
        fields: 'userEnteredFormat.numberFormat',
      },
    },
    {
      setDataValidation: {
        range: { sheetId: id, startRowIndex: 1, endRowIndex: rows, startColumnIndex: 4, endColumnIndex: 5 },
        rule: {
          condition: { type: 'ONE_OF_LIST', values: [{ userEnteredValue: 'Out' }, { userEnteredValue: 'Returned' }] },
          showCustomUi: true,
          strict: true,
        },
      },
    },
    { updateCells: { start: { sheetId: id, rowIndex: 1, columnIndex: 4 }, rows: status, fields: 'userEnteredValue' } },
    ...fixes.map(({ row, to }) => ({
      updateCells: {
        start: { sheetId: id, rowIndex: row - 1, columnIndex: 0 },
        rows: [{ values: [{ userEnteredValue: { stringValue: to } }] }],
        fields: 'userEnteredValue',
      },
    })),
    // Mild first, strong second: both go in at index 0, so the strong rule
    // ends up above the mild one, and Sheets applies the first rule that fits.
    ...(existing.includes(STILL_OUT) ? [] : [rule(STILL_OUT, MILD)]),
    ...(existing.includes(LAST_COPY) ? [] : [rule(LAST_COPY, strong)]),
  ];
}

/* -- phases R and I: the formulas ------------------------------------------- */

function formulaData(tab, column, firstRow, lastRow) {
  const values = [];
  for (let r = firstRow; r <= lastRow; r++) values.push([availability(r)]);
  return [{ range: `${quoted(tab.title)}!${column}${firstRow}:${column}${lastRow}`, values }];
}

/* -- verification ----------------------------------------------------------- */

async function verify() {
  const state = await readState();
  const reshaped = signoutsReshaped(state);
  const sCol = reshaped ? 4 : 3;
  const open = new Map();
  const count = (title) => open.set(title.toLowerCase(), (open.get(title.toLowerCase()) ?? 0) + 1);
  for (const r of state.borrowed.slice(2)) {
    const s = trimmed(r[5] ?? '');
    if ((s === 'Out' || s === 'Overdue') && trimmed(r[0] ?? '') !== '') count((r[0] ?? '').toString());
  }
  for (const r of state.signouts.slice(1)) {
    const book = (r[0] ?? '').toString();
    if (trimmed(book) === '' || Number.isFinite(Number(book))) continue;
    const s = trimmed(r[sCol] ?? '').toLowerCase();
    if (!(s === 'true' || s.startsWith('return'))) count(book);
  }

  const check = (rows, tab, availCol, lastIndex) => {
    const out = [];
    const wrong = [];
    for (let i = 1; i <= lastIndex; i++) {
      const title = (rows[i]?.[0] ?? '').toString();
      if (trimmed(title) === '') continue;
      const copies = Number(rows[i]?.[2] ?? 0) || 0;
      const expect = copies - (open.get(title.toLowerCase()) ?? 0) <= 0 ? 'Out' : 'In';
      const got = trimmed(rows[i]?.[availCol] ?? '');
      if (expect === 'Out') out.push(title);
      if (got !== expect) wrong.push(`${tab}!${String.fromCharCode(65 + availCol)}${i + 1} "${title}": sheet says "${got}", loans say "${expect}"`);
    }
    return { out, wrong };
  };
  const a = check(state.index, 'Book_Index', 3, state.index.length - 1);
  const b = check(state.restricted, 'Restricted Titles', 4, restrictedTitleRows(state.restricted));

  console.log('\nOut, by the loans:');
  for (const t of [...a.out, ...b.out]) console.log(`  ${t}`);
  if (a.out.length + b.out.length === 0) console.log('  (nothing)');
  if (a.wrong.length + b.wrong.length === 0) console.log('\nThe sheet agrees on every title.');
  else {
    console.log('\nDISAGREEMENTS:');
    for (const w of [...a.wrong, ...b.wrong]) console.log(`  ${w}`);
  }

  const { unmatched } = legacyFixes(state, reshaped);
  if (unmatched.length > 0) {
    console.log('\nOpen signouts whose spelling matches no title, which the formula will not count:');
    for (const u of unmatched) console.log(`  row ${u.row}: ${JSON.stringify(u.from)}`);
  }
}

/* -- main ------------------------------------------------------------------- */

console.log(`register: ${sheetId}\nas:       ${account.client_email}\nmode:     ${APPLY ? 'APPLY' : 'dry run'}${ONLY ? ` (only ${ONLY})` : ''}`);

const state = await readState();
const { problems, notes } = preflight(state);
for (const n of notes) console.log(`note: ${n}`);
if (problems.length > 0) {
  console.error('\nNot proceeding:');
  for (const p of problems) console.error(`  ${p}`);
  process.exit(1);
}

const wants = (phase) => ONLY === null || ONLY === phase;
const reshaped = signoutsReshaped(state);
const restrictedDone = trimmed(cellOf(state.restrictedE, 1, 0)).startsWith('=');
const indexDone = trimmed(cellOf(state.indexD, 1, 0)).startsWith('=');

console.log(`\nLibrary_Signouts: ${reshaped ? 'already reshaped' : 'to reshape'}`);
console.log(`Restricted Titles!E: ${restrictedDone ? 'already a formula' : 'to write'}`);
console.log(`Book_Index!D: ${indexDone ? 'already a formula' : 'to write'}`);

if (!reshaped && wants('signouts')) {
  const header = state.signouts[0]?.map(trimmed) ?? [];
  if (header[3] !== 'Returned?') {
    console.error(`\nLibrary_Signouts!D1 is "${header[3]}", not "Returned?": the tab is not in the shape this expects.`);
    process.exit(1);
  }
  const { fixes, unmatched } = legacyFixes(state, false);
  console.log('\nLegacy open rows to respell:');
  for (const f of fixes) console.log(`  row ${f.row}: ${JSON.stringify(f.from)} -> ${JSON.stringify(f.to)}`);
  if (fixes.length === 0) console.log('  (none)');
  for (const u of unmatched) console.log(`  row ${u.row}: ${JSON.stringify(u.from)} matches nothing; left as is`);
  const requests = signoutsRequests(state);
  console.log(`\n${requests.length} requests in one batch: ${requests.map((r) => Object.keys(r)[0]).join(', ')}`);
}

if (!APPLY) {
  console.log('\nDry run. Add --apply to write.');
  if (reshaped || restrictedDone || indexDone) await verify();
  process.exit(0);
}

// The pre-state, on disk, before anything changes.
if (!(reshaped && restrictedDone && indexDone)) {
  const dump = await get(
    `?includeGridData=true&ranges=${Object.values(TABS)
      .map((t) => encodeURIComponent(`${quoted(t.title)}!A1:L500`))
      .join('&ranges=')}`,
  );
  fs.writeFileSync(BACKUP, JSON.stringify(dump));
  console.log(`\nbackup: ${BACKUP}`);
}

if (!reshaped && wants('signouts')) {
  await batchUpdate(signoutsRequests(state));
  console.log('Library_Signouts reshaped.');
}

const after = await readState();
if (!signoutsReshaped(after) && (wants('restricted') || wants('index'))) {
  console.error('\nThe formulas name Library_Signouts!E as the status column; reshape it first.');
  process.exit(1);
}

if (!restrictedDone && wants('restricted')) {
  const last = restrictedTitleRows(after.restricted) + 1;
  await writeValues(formulaData(TABS.restricted, 'E', 2, last));
  console.log(`Restricted Titles!E2:E${last} written.`);
}

if (!indexDone && wants('index')) {
  const rows = after.byId[TABS.index.id].properties.gridProperties.rowCount;
  try {
    await writeValues(formulaData(TABS.index, 'D', 2, rows));
    console.log(`Book_Index!D2:D${rows} written.`);
  } catch (err) {
    if (err instanceof SheetsError && /protected/i.test(err.detail)) {
      console.error(`\nBook_Index is protected against ${account.client_email}. Paste this into D2 and fill it down to D${rows}:\n`);
      console.error(`  ${availability(2)}\n`);
      console.error('then re-run this script to verify.');
    } else if (err instanceof SheetsError && err.status === 403) {
      console.error(`\nThe register is not shared with ${account.client_email} as an editor.`);
      process.exit(1);
    } else throw err;
  }
}

await verify();
