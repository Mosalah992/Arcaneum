/**
 * Regenerates the library migrations from the markdown in content/library/.
 *
 *     node scripts/build-seed.mjs
 *
 * The books are authored as plain markdown with frontmatter so the corpus can
 * be re-imported or corrected without anyone hand-editing SQL.
 *
 * ONE MIGRATION PER SHELF. The corpus is 1.7 MB of prose; as a single file it
 * would be a megabyte-and-a-half statement batch, which `wrangler d1 migrations
 * apply` does not enjoy and which is unreadable in a diff. Each shelf gets its
 * own numbered file and the first one carries the DELETEs.
 *
 * MIGRATIONS ARE AN APPEND-ONLY LEDGER and this generator rewrites in place, so
 * regenerating content means resetting the database rather than applying a
 * delta. `npm run db:reset` does that locally; see the README for the remote.
 *
 * CITATIONS ARE DERIVED, NOT DECLARED. Bethesda's text is never edited, so the
 * archive cannot print its own call numbers inside a book. Instead every body
 * is scanned for the titles of other books in the corpus, and each hit becomes
 * a `citations` row — which the reader turns back into call numbers in its own
 * apparatus, as a colophon in the librarian's hand.
 */

import { readFileSync, writeFileSync, readdirSync, mkdirSync, rmSync, existsSync } from 'node:fs';
import { join } from 'node:path';

const CONTENT_DIR = join('content', 'library');
const MIGRATIONS = 'migrations';

/**
 * The shelves, read out of the TypeScript rather than copied.
 *
 * This script cannot import a .ts file, and the previous version of it kept its
 * own hand-maintained duplicate of the list with a comment asking the reader to
 * keep the two in step. Eleven strings in two places is a drift waiting to
 * happen; parsing the one source and failing loudly is cheaper than the bug.
 */
function readShelves() {
  const source = readFileSync(join('shared', 'shelves.ts'), 'utf8');
  const block = source.match(/export const SHELVES = \[([\s\S]*?)\] as const;/);
  if (block === null) throw new Error('shared/shelves.ts: could not find the SHELVES array');
  const shelves = [...block[1].matchAll(/'([^']+)'/g)].map((m) => m[1]);
  if (shelves.length === 0) throw new Error('shared/shelves.ts: SHELVES parsed as empty');
  return shelves;
}

const SHELVES = readShelves();
const ROMAN = { I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000 };

function romanValue(s) {
  let total = 0;
  for (let i = 0; i < s.length; i++) {
    const here = ROMAN[s[i]];
    const next = ROMAN[s[i + 1]];
    total += next > here ? -here : here;
  }
  return total;
}

/** Shelf-order sort: roman tier first, then accession number. */
function callNumberOrder(cn) {
  const [, tier, acc] = cn.match(/^AR-([IVXLCDM]+)-(\d+)$/);
  return romanValue(tier) * 100000 + Number(acc);
}

function parse(file) {
  const raw = readFileSync(join(CONTENT_DIR, file), 'utf8').replace(/\r\n/g, '\n');
  const lines = raw.split('\n');
  if (lines[0].trim() !== '---') throw new Error(`${file}: missing frontmatter`);
  const end = lines.indexOf('---', 1);
  if (end === -1) throw new Error(`${file}: unterminated frontmatter`);

  const meta = {};
  for (const line of lines.slice(1, end)) {
    if (!line.trim()) continue;
    const at = line.indexOf(':');
    if (at === -1) throw new Error(`${file}: bad frontmatter line "${line}"`);
    // Split on the FIRST colon only: titles carry them ("Liminal Bridges:
    // Simplified") and so does every source URL.
    meta[line.slice(0, at).trim()] = line.slice(at + 1).trim();
  }

  const body = lines.slice(end + 1).join('\n').trim();

  for (const key of ['call_number', 'title', 'author', 'school', 'restricted']) {
    if (!(key in meta)) throw new Error(`${file}: frontmatter missing "${key}"`);
  }
  if (!SHELVES.includes(meta.school)) {
    throw new Error(`${file}: unknown shelf "${meta.school}"`);
  }
  if (!/^AR-[IVXLCDM]+-\d{3}$/.test(meta.call_number)) {
    throw new Error(`${file}: malformed call number "${meta.call_number}"`);
  }
  /*
   * The literal, and only the literal.
   *
   * This used to be `meta.restricted === 'true'`, which silently unseals a book
   * on any typo — `True`, `yes`, `1` all read as false and nothing says so. A
   * sealed book quietly becoming public is exactly the failure this project
   * should refuse to make quietly.
   */
  if (meta.restricted !== 'true' && meta.restricted !== 'false') {
    throw new Error(`${file}: restricted must be exactly true or false, not "${meta.restricted}"`);
  }
  if (body.length === 0) throw new Error(`${file}: empty body`);

  return {
    call_number: meta.call_number,
    title: meta.title,
    author: meta.author,
    school: meta.school,
    restricted: meta.restricted === 'true' ? 1 : 0,
    body,
  };
}

const q = (s) => `'${String(s).replace(/'/g, "''")}'`;

/**
 * How much body goes in one statement.
 *
 * D1 refuses an oversized statement outright — SQLITE_TOOBIG — and six books
 * here are large enough to trip it, two of them over 120 KB ("The Real
 * Barenziah" and "2920, The Last Year of the First Era"). So a long body is
 * inserted as its first slice and appended to by further statements, none of
 * which is ever big. 30 KB leaves room for the doubling that escaping a body
 * full of quotation marks can cause.
 */
const CHUNK = 30_000;

/** Slice without splitting a surrogate pair down the middle. */
function chunks(text) {
  const out = [];
  let at = 0;
  while (at < text.length) {
    let end = Math.min(at + CHUNK, text.length);
    const code = text.charCodeAt(end - 1);
    if (end < text.length && code >= 0xd800 && code <= 0xdbff) end -= 1;
    out.push(text.slice(at, end));
    at = end;
  }
  return out;
}

const books = readdirSync(CONTENT_DIR)
  .filter((f) => f.endsWith('.md'))
  .map(parse)
  .sort((a, b) => callNumberOrder(a.call_number) - callNumberOrder(b.call_number));

if (books.length === 0) throw new Error(`${CONTENT_DIR} holds no books`);

const byCallNumber = new Map(books.map((b, i) => [b.call_number, i + 1]));

/* -- citations ------------------------------------------------------------ */

/**
 * A title is only worth searching for if it could not turn up by accident.
 *
 * "Sithis", "Dwarves", "Palla" and "The Mirror" are all real books here, and
 * all of them appear as ordinary words in dozens of others. Requiring two words
 * and a dozen characters keeps the cross-references to titles distinctive
 * enough that a hit means a reference.
 */
const MIN_TITLE_WORDS = 2;
const MIN_TITLE_LENGTH = 12;

const escapeRe = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

const searchable = books.filter(
  (b) => b.title.length >= MIN_TITLE_LENGTH && b.title.split(/\s+/).length >= MIN_TITLE_WORDS,
);

/**
 * The archive's own cross-references, resolved from titles to call numbers.
 *
 * Derived references alone cannot reach the sealed shelf — see
 * content/cross-references.json for why these exist and why they are the
 * archive speaking rather than the author.
 */
const byTitle = new Map(books.map((b) => [b.title, b]));
const curated = JSON.parse(
  readFileSync(join('content', 'cross-references.json'), 'utf8'),
).references;

const curatedByCallNumber = new Map();
for (const ref of curated) {
  const from = byTitle.get(ref.from);
  const cites = byTitle.get(ref.cites);
  if (from === undefined) throw new Error(`cross-references.json: no book titled "${ref.from}"`);
  if (cites === undefined) throw new Error(`cross-references.json: no book titled "${ref.cites}"`);
  if (from.call_number === cites.call_number) {
    throw new Error(`cross-references.json: "${ref.from}" refers to itself`);
  }
  const list = curatedByCallNumber.get(from.call_number) ?? [];
  list.push(cites.call_number);
  curatedByCallNumber.set(from.call_number, list);
}

const citations = [];
for (const [index, book] of books.entries()) {
  const found = new Set();

  // Titles of other books, as printed.
  for (const other of searchable) {
    if (other.call_number === book.call_number) continue;
    const pattern = new RegExp(`(^|[^\\w])${escapeRe(other.title)}([^\\w]|$)`, 'i');
    if (pattern.test(book.body)) found.add(other.call_number);
  }

  // And any call number written out longhand, which is how the archive's own
  // marginalia would refer to a volume if one were ever added by hand.
  for (const cn of book.body.match(/\bAR-[IVXLCDM]+-\d{3}\b/g) ?? []) {
    if (cn !== book.call_number && byCallNumber.has(cn)) found.add(cn);
  }

  for (const cn of curatedByCallNumber.get(book.call_number) ?? []) found.add(cn);

  for (const cn of [...found].sort()) citations.push({ from: index + 1, cites: cn });
}

/* -- how the sealed shelf is reached -------------------------------------- */
//
// This used to be a build failure. It is a report now, because the catalogue
// lists restricted titles openly — they are on the College's own register with
// a location and a copy count, so hiding them here was never access control,
// only a game, and it is a game the register does not play. A sealed book
// nothing points at is still worth knowing about (the cross-references are the
// archive's apparatus and a gap in them is a gap), but it no longer stops a
// build: nobody can fail to find a book that is on the shelf list.

const sealed = books.filter((b) => b.restricted === 1);
const orphans = [];
for (const book of sealed) {
  const from = citations
    .filter((c) => c.cites === book.call_number)
    .map((c) => books[c.from - 1])
    .filter((b) => b.restricted === 0);
  if (from.length === 0) orphans.push(book);
}

/* -- emit ----------------------------------------------------------------- */

// Clear the shelf migrations this script owns before writing, so a shelf that
// loses all its books does not leave a stale file behind to be applied.
for (const file of readdirSync(MIGRATIONS)) {
  if (/^\d{4}_library_/.test(file)) rmSync(join(MIGRATIONS, file));
}
if (existsSync(join(MIGRATIONS, '0002_seed_content.sql'))) {
  rmSync(join(MIGRATIONS, '0002_seed_content.sql'));
}
mkdirSync(MIGRATIONS, { recursive: true });

const slug = (s) => s.toLowerCase().replace(/[^a-z0-9]+/g, '_').replace(/^_|_$/g, '');

let written = 0;
SHELVES.forEach((shelf, shelfIndex) => {
  const mine = books.filter((b) => b.school === shelf);
  const number = String(2 + shelfIndex).padStart(4, '0');
  const path = join(MIGRATIONS, `${number}_library_${slug(shelf)}.sql`);

  const out = [];
  out.push(`-- Migration ${number} — ${shelf}.`);
  out.push('--');
  out.push('-- GENERATED FILE. Do not edit by hand: edit the markdown in');
  out.push('-- content/library/ and re-run `npm run seed`.');
  out.push('--');
  out.push('-- The prose is Bethesda\'s, ported from the Library of Skyrim.');
  out.push('-- See PROVENANCE.md.');
  out.push('');

  if (shelfIndex === 0) {
    out.push('-- The first shelf clears the shelves. This generator rewrites in place,');
    out.push('-- so re-applying it is a reset rather than a delta.');
    out.push('DELETE FROM citations;');
    out.push('DELETE FROM tomes;');
    out.push('');
  }

  for (const book of mine) {
    const id = byCallNumber.get(book.call_number);
    const parts = chunks(book.body);
    out.push(`-- ${book.call_number} — ${book.title}${book.restricted ? '  [SEALED]' : ''}`);
    out.push('INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES');
    out.push(`  (${id}, ${q(book.call_number)}, ${q(book.title)}, ${q(book.author)}, ${q(book.school)},`);
    out.push(`   ${q(parts[0])}, ${book.restricted});`);
    for (const part of parts.slice(1)) {
      out.push(`UPDATE tomes SET body = body || ${q(part)} WHERE id = ${id};`);
    }
    out.push('');
  }

  const mineIds = new Set(mine.map((b) => byCallNumber.get(b.call_number)));
  const ours = citations.filter((c) => mineIds.has(c.from));
  if (ours.length > 0) {
    out.push('-- Cross-references, derived from the titles named in these bodies.');
    for (const c of ours) {
      out.push(`INSERT INTO citations (from_tome, cites_call_number) VALUES (${c.from}, ${q(c.cites)});`);
    }
    out.push('');
  }

  writeFileSync(path, out.join('\n'), 'utf8');
  written += 1;
  console.log(`  ${path}  ${String(mine.length).padStart(3)} books  ${String(ours.length).padStart(4)} refs`);
});

const bytes = books.reduce((n, b) => n + b.body.length, 0);
console.log(`\n${books.length} books across ${written} shelf migrations`);
console.log(
  `  ${(bytes / 1024).toFixed(0)} KB of prose, ${citations.length} cross-references ` +
    `(${curated.length} of them the archive's own)`,
);
console.log(`  ${sealed.length} sealed: ${sealed.map((b) => b.call_number).join(', ')}`);

for (const book of sealed) {
  const from = citations
    .filter((c) => c.cites === book.call_number)
    .map((c) => books[c.from - 1])
    .filter((b) => b.restricted === 0)
    .map((b) => b.call_number);
  console.log(`    ${book.call_number} ${book.title} — reachable from: ${from.join(', ') || 'NOWHERE'}`);
}

/*
 * A sealed book nothing points at cannot be found.
 *
 * The whole mechanic is that a reader meets a title in a book they can already
 * read and asks for it at the desk. A sealed book with no unrestricted
 * reference to it is not mysterious, it is missing — so this is a build
 * failure and not a warning.
 */
if (orphans.length > 0) {
  console.error(`\n${orphans.length} sealed book(s) reachable from nowhere:`);
  for (const b of orphans) console.error(`  ${b.call_number} ${b.title}`);
  console.error('\nEither cite them from an open book or unseal them in content/restricted.json.');
  process.exitCode = 1;
}
