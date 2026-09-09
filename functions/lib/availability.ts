/**
 * What the College actually holds, read from its own register.
 *
 * ONE MODULE IS THE WHOLE SEAM. Everything Google-shaped lives here: the
 * service-account JWT, the batch read, and the arithmetic that turns loan rows
 * into "is there a copy on the shelf". The route above it and the chips in the
 * catalogue know nothing but the shape this returns.
 *
 * READ-ONLY, and minted with the readonly scope, so a bug in this archive
 * cannot disturb the columns the librarians own. The signer is ported from the
 * Thalmor archive's server/gsheets.ts, which has been running this exact flow
 * against this exact service account; it needs no dependency because
 * WebCrypto can sign RS256 on the Cloudflare runtime.
 *
 * AVAILABILITY IS DERIVED, NOT READ. The register has an `Availability` column
 * and it reads "In" on all 109 rows of it, restricted titles included — it is a
 * field nobody has ever had cause to change, and it would go stale the moment
 * somebody did. What is real is `Copies` against the open rows of
 * `Borrowed_Books` and `Library_Signouts`, so that is what this counts.
 *
 * THE RANGES AND COLUMNS BELOW WERE READ OFF THE LIVE SHEET, not off a copy.
 * An earlier version of this file was written against a downloaded `.xlsx`
 * export and had every tab name wrong (`Book Index` for `Book_Index`, `Book
 * Borrowing` for `Borrowed_Books`, `In-Library Signouts` for
 * `Library_Signouts`) and the borrowing sheet's title column off by one. It
 * would have failed silently — a bad range is a 400, and this module's caller
 * turns every failure into `configured: false`, which looks exactly like a
 * sheet that was never connected.
 */

import { normaliseTitle, withoutVolume, workKey } from '../../shared/titles';

const SCOPE = 'https://www.googleapis.com/auth/spreadsheets.readonly';

/**
 * The sheets, and how far across and down each one the data goes.
 *
 * Read generously — the register grows — but not open-ended: `A1:E` with no row
 * bound returns every blank row the grid has, and `Library_Signouts` has three
 * hundred of them with `FALSE` pre-filled in the returned column.
 */
const RANGES = [
  "'Book_Index'!A1:E200",
  "'Borrowed_Books'!A1:H400",
  "'Library_Signouts'!A1:E500",
  "'Restricted Titles'!A1:G60",
];

export interface Holding {
  title: string;
  /** Where in the College it stands: R1–R5 open, L1 the restricted press. */
  location: string;
  copies: number;
  out: number;
  available: number;
  /** On the restricted register, and why. Empty for an open title. */
  note: string;
  restricted: boolean;
  /** Register rows folded into this one. 1 unless it is a work in volumes. */
  volumes: number;
}

export interface Register {
  /** Normalised title -> holding. */
  holdings: Record<string, Holding>;
  /** Titles the register names that the catalogue does not, and vice versa. */
  unmatched: string[];
  fetchedAt: string;
}

export interface SheetsEnv {
  ARCANAEUM_SHEET_ID?: string;
  GOOGLE_SERVICE_ACCOUNT_JSON?: string;
}

/* -- the token ------------------------------------------------------------ */

const b64url = (bytes: ArrayBuffer | Uint8Array): string =>
  btoa(String.fromCharCode(...new Uint8Array(bytes)))
    .replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=+$/, '');

const b64urlJSON = (value: unknown): string =>
  b64url(new TextEncoder().encode(JSON.stringify(value)));

function pemToPkcs8(pem: string): ArrayBuffer {
  const body = pem.replace(/-----(BEGIN|END) PRIVATE KEY-----/g, '').replace(/\s/g, '');
  const binary = atob(body);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);
  return bytes.buffer;
}

// Isolates are reused between requests, so a module-scope cache saves a token
// exchange on most of them.
let cachedToken: { token: string; expires: number } | null = null;

async function accessToken(env: SheetsEnv): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  if (cachedToken !== null && now < cachedToken.expires - 300) return cachedToken.token;

  const raw = env.GOOGLE_SERVICE_ACCOUNT_JSON;
  if (raw === undefined || raw === '') throw new Error('no service account configured');

  // Strip a UTF-8 BOM picked up when the secret was pasted in.
  const account = JSON.parse(raw.replace(/^﻿/, '').trim()) as {
    client_email: string;
    private_key: string;
    token_uri: string;
  };

  const header = b64urlJSON({ alg: 'RS256', typ: 'JWT' });
  const claims = b64urlJSON({
    iss: account.client_email,
    scope: SCOPE,
    aud: account.token_uri,
    iat: now,
    exp: now + 3600,
  });

  const key = await crypto.subtle.importKey(
    'pkcs8',
    pemToPkcs8(account.private_key),
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const signature = await crypto.subtle.sign(
    'RSASSA-PKCS1-v1_5',
    key,
    new TextEncoder().encode(`${header}.${claims}`),
  );

  const res = await fetch(account.token_uri, {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body:
      `grant_type=${encodeURIComponent('urn:ietf:params:oauth:grant-type:jwt-bearer')}` +
      `&assertion=${header}.${claims}.${b64url(signature)}`,
  });

  const data = (await res.json()) as { access_token?: string; expires_in?: number };
  if (!res.ok || data.access_token === undefined) {
    throw new Error(`token exchange failed (${res.status})`);
  }

  cachedToken = { token: data.access_token, expires: now + (data.expires_in ?? 3600) };
  return cachedToken.token;
}

/* -- the read ------------------------------------------------------------- */

const cell = (row: string[] | undefined, at: number): string => (row?.[at] ?? '').trim();

/** "Returned", "1", "TRUE", "yes" — anything that means the book came back. */
function isClosed(value: string): boolean {
  const v = value.trim().toLowerCase();
  return v === '1' || v === 'true' || v === 'yes' || v === 'y' || v.startsWith('return');
}

export async function readRegister(env: SheetsEnv): Promise<Register> {
  const sheetId = env.ARCANAEUM_SHEET_ID;
  if (sheetId === undefined || sheetId === '') throw new Error('no sheet configured');

  const token = await accessToken(env);
  const query = RANGES.map((r) => `ranges=${encodeURIComponent(r)}`).join('&');
  const res = await fetch(
    `https://sheets.googleapis.com/v4/spreadsheets/${sheetId}/values:batchGet?${query}`,
    { headers: { authorization: `Bearer ${token}` } },
  );
  if (!res.ok) throw new Error(`sheets read failed (${res.status})`);

  const body = (await res.json()) as { valueRanges?: { values?: string[][] }[] };
  const [index, borrowing, signouts, restricted] = (body.valueRanges ?? []).map(
    (r) => r.values ?? [],
  );

  /*
   * One entry per register row, keyed by its own exact title. The loans below
   * name volumes — `The Real Barenziah, v3` — so they are applied here, before
   * anything is aggregated.
   */
  const rows: Record<string, Holding> = {};

  const hold = (
    title: string,
    location: string,
    copies: number,
    note: string,
    sealed: boolean,
  ): void => {
    rows[normaliseTitle(title)] = {
      title,
      location,
      copies,
      out: 0,
      available: copies,
      note,
      restricted: sealed,
      volumes: 1,
    };
  };

  // Book_Index: A Title, B Location, C Copies, D Availability, E Volumes.
  // Row 1 is the header, and it carries the sheet's own totals off in F..I,
  // which is why the range stops at E.
  for (const row of (index ?? []).slice(1)) {
    const title = cell(row, 0);
    if (title === '' || title.toLowerCase() === 'title') continue;
    hold(title, cell(row, 1), Number(cell(row, 2)) || 0, '', false);
  }

  /*
   * Restricted Titles: A Title, B Location, C Copies, D Type, E Availability,
   * F Volumes, G Note. One column wider than Book_Index, because of `Type`.
   *
   * The tab holds TWO tables. The eight restricted books come first, and below
   * them the sheet repeats its own header — `Spell Tome | Location | ...` — and
   * starts a second list of spell tomes, which are stock rather than volumes
   * and answer to no book in this catalogue. The second header is the stop: a
   * row whose B cell is the literal word `Location` ends the reading.
   */
  for (const row of (restricted ?? []).slice(1)) {
    const title = cell(row, 0);
    if (cell(row, 1).toLowerCase() === 'location') break;
    if (title === '' || title.toLowerCase() === 'title') continue;
    hold(title, cell(row, 1), Number(cell(row, 2)) || 0, cell(row, 6), true);
  }

  const unmatched = new Set<string>();
  const takeOut = (title: string): void => {
    if (title === '') return;
    const holding = rows[normaliseTitle(title)];
    if (holding === undefined) {
      unmatched.add(title);
      return;
    }
    holding.out += 1;
    holding.available = Math.max(0, holding.copies - holding.out);
  };

  /*
   * Borrowed_Books: A the book, F the status. Row 1 is a READ ME addressed to
   * the librarians and row 2 is the header, so the data starts at row 3.
   *
   * A blank status is not an unrecorded loan — the only rows in the sheet with
   * a value in A and nothing in F are the three semester dividers
   * (`2nd Semester, 7/3/2026`), so a row without both is not a loan at all.
   * What is left is `Returned`, `Out` and `Overdue`.
   */
  for (const row of (borrowing ?? []).slice(2)) {
    const book = cell(row, 0);
    const status = cell(row, 5);
    if (book === '' || status === '' || book.toLowerCase() === 'book') continue;
    if (!isClosed(status)) takeOut(book);
  }

  // Library_Signouts: A the book, D whether it came back. The blank tail of
  // the grid carries `FALSE` in D all the way down, so the empty A is what
  // keeps three hundred phantom loans out of the count.
  for (const row of (signouts ?? []).slice(1)) {
    const book = cell(row, 0);
    if (book === '' || Number.isFinite(Number(book))) continue;
    if (!isClosed(cell(row, 3))) takeOut(book);
  }

  /*
   * Fold the volumes into their works, and answer to both names.
   *
   * A catalogue asking for `The Real Barenziah` gets the five register rows
   * added up; one asking for `The Real Barenziah, v3` — if it ever did — still
   * gets that row alone. An exact title always wins: a work aggregate is only
   * written where no register row is called that already.
   */
  const holdings: Record<string, Holding> = { ...rows };
  const works = new Map<string, Holding[]>();

  for (const [key, holding] of Object.entries(rows)) {
    const work = workKey(holding.title);
    if (work === key || work === '') continue;
    works.set(work, [...(works.get(work) ?? []), holding]);
  }

  for (const [work, group] of works) {
    if (rows[work] !== undefined) continue;
    const locations = [...new Set(group.map((h) => h.location).filter((l) => l !== ''))];
    holdings[work] = {
      // The register's own words, minus the volume number it was filed under.
      title: withoutVolume(group[0]!.title),
      location: locations.join(', '),
      copies: group.reduce((n, h) => n + h.copies, 0),
      out: group.reduce((n, h) => n + h.out, 0),
      available: group.reduce((n, h) => n + h.available, 0),
      note: group.find((h) => h.note !== '')?.note ?? '',
      restricted: group.some((h) => h.restricted),
      volumes: group.length,
    };
  }

  return {
    holdings,
    unmatched: [...unmatched].sort(),
    fetchedAt: new Date().toISOString(),
  };
}
