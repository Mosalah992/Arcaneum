// One-off importer for volumes the archive was missing.
//
// Reads a list of titles, fetches each one's text, writes a markdown file per
// book into content/library/ with the next free call number on its shelf, and
// emits ONE migration that inserts them all and rebuilds the search index.
//
// CALL NUMBERS CONTINUE THE SHELF, they do not renumber it. Accession order is
// how a library actually assigns them and it is why the catalogue sorts by call
// number rather than by row id — a book added today goes at the end of its
// shelf and nothing above it moves.
//
// SHELVES ARE ASSIGNED HERE, BY HAND, in the table below. There is no field in
// the source that maps onto this archive's eleven shelves, so the alternative
// to judgement is a wrong shelf chosen mechanically. Anything mis-shelved is
// one edit to a frontmatter line and a re-run of `npm run seed`.

import { readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

const LIBRARY = new URL('../content/library/', import.meta.url).pathname.replace(/^\//, '');
const MIGRATION = new URL('../migrations/0016_addenda.sql', import.meta.url).pathname.replace(/^\//, '');
const RESTRICTED = new URL('../content/restricted.json', import.meta.url).pathname.replace(/^\//, '');
const MIGRATIONS = new URL('../migrations/', import.meta.url).pathname.replace(/^\//, '');

/** Shelf order is load-bearing: the index is the roman tier in a call number. */
const SHELVES = [
  'Biographies', 'Faction Books', 'Fiction', 'History & Lore',
  'Instruction & Research', 'Journals & Logs', 'Notes & Letters',
  'Plays, Poetry & Riddles', 'Politics & Law', 'Religion & Prophecy', 'Travel',
];
const ROMAN = ['I','II','III','IV','V','VI','VII','VIII','IX','X','XI'];

/** title -> shelf. Judged from what the book is, not from where it was found. */
const SHELF_OF = {
  'Aevar Stone-Singer': 'Religion & Prophecy',
  'An Accounting of the Scrolls': 'Instruction & Research',
  'Azura and the Box': 'Religion & Prophecy',
  'Beggar': 'Fiction',
  "Cherim's Heart": 'History & Lore',
  'Chimarvamidium': 'History & Lore',
  'De Rerum Dirennis': 'Instruction & Research',
  'Fire and Darkness': 'Faction Books',
  'Frontier, Conquest': 'History & Lore',
  'Gods and Worship': 'Religion & Prophecy',
  'Great Harbingers': 'Faction Books',
  'Hanging Gardens': 'History & Lore',
  'Ice and Chitin': 'Faction Books',
  "Jornibret's Last Dance": 'Fiction',
  'King': 'Fiction',
  'Legend of Krately House': 'Fiction',
  'Lost Legends': 'History & Lore',
  'Mannimarco, King of Worms': 'Plays, Poetry & Riddles',
  "N'Gasta! Kvata! Kvakis!": 'Religion & Prophecy',
  'Night Falls on Sentinel': 'Fiction',
  'Racial Phylogeny': 'Instruction & Research',
  "Response to Bero's Speech": 'Instruction & Research',
  'Rislav The Righteous': 'Biographies',
  'Song of the Alchemists': 'Plays, Poetry & Riddles',
  "The Armorer's Challenge": 'Fiction',
  'The Doors of Oblivion': 'Instruction & Research',
  'The Dowry': 'Fiction',
  'The Importance of Where': 'Instruction & Research',
  'The Ransom of Zarek': 'Fiction',
  'The Red Kitchen Reader': 'Fiction',
  'The Seed': 'Fiction',
  "The Warrior's Charge": 'Plays, Poetry & Riddles',
  'Thief': 'Fiction',
  'Warrior': 'Fiction',
  'Words and Philosophy': 'Instruction & Research',
  'Words of Clan Mother Ahnissi': 'Religion & Prophecy',
};

const UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' +
  '(KHTML, like Gecko) Chrome/131.0 Safari/537.36';

async function api(params) {
  const u = new URL('https://en.uesp.net/w/api.php');
  for (const [k, v] of Object.entries(params)) u.searchParams.set(k, v);
  const res = await fetch(u, { headers: { 'user-agent': UA } });
  if (!res.ok) throw new Error(`${params.page ?? params.cmtitle} -> HTTP ${res.status}`);
  return res.json();
}

const ENTITIES = {
  amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' ',
  mdash: '—', ndash: '–', hellip: '…',
  lsquo: '‘', rsquo: '’', ldquo: '“', rdquo: '”',
};
const decode = (s) =>
  s.replace(/&(#x?[0-9a-f]+|[a-z]+);/gi, (m, g) => {
    if (g[0] === '#') {
      const n = g[1] === 'x' || g[1] === 'X' ? parseInt(g.slice(2), 16) : parseInt(g.slice(1), 10);
      return Number.isFinite(n) ? String.fromCodePoint(n) : m;
    }
    return ENTITIES[g.toLowerCase()] ?? m;
  });

/**
 * The book's own text, as the blocks `src/lib/markdown.ts` understands.
 *
 * THE OPENING CAPITAL IS AN IMAGE, not a character — an `<img alt="A">` drop
 * cap. Taking the alt is what keeps the first letter of the book; stripping
 * tags first silently eats it and the volume opens on "fter many battles".
 */
function bookText(html) {
  // Verse is not in a `book` div — it is in a `poem` one. Six volumes came back
  // empty on the first run for exactly that reason, and an empty volume that
  // looks fine in the catalogue is worse than a fetch that admits it failed.
  // A regex, not indexOf: these containers carry other attributes —
  // `<div class="poem" style="...">` — and an exact-string search misses them.
  const open = /<div class="(?:book|poem)"[^>]*>/i.exec(html);
  if (open === null) return null;
  const start = open.index;

  let depth = 0;
  let end = html.length;
  const tag = /<\/?div\b[^>]*>/gi;
  tag.lastIndex = start;
  for (let m; (m = tag.exec(html)); ) {
    depth += m[0][1] === '/' ? -1 : 1;
    if (depth === 0) { end = m.index + m[0].length; break; }
  }

  let s = html.slice(start, end);
  s = s.replace(/<style[\s\S]*?<\/style>/gi, '').replace(/<script[\s\S]*?<\/script>/gi, '');
  s = s.replace(/<sup[^>]*>[\s\S]*?<\/sup>/gi, '');
  s = s.replace(/<img\b[^>]*\balt="([A-Za-z])"[^>]*>/gi, '$1');
  s = s.replace(/<img\b[^>]*>/gi, '');
  s = s.replace(/<h([1-6])[^>]*>([\s\S]*?)<\/h\1>/gi, (_, __, t) => `\n\n## ${t.replace(/<[^>]+>/g, '').trim()}\n\n`);
  s = s.replace(/<br\s*\/?>/gi, '\n');
  s = s.replace(/<\/p>|<\/div>|<\/tr>/gi, '\n\n');
  s = s.replace(/<i>|<em>/gi, '*').replace(/<\/i>|<\/em>/gi, '*');
  s = s.replace(/<b>|<strong>/gi, '**').replace(/<\/b>|<\/strong>/gi, '**');
  s = s.replace(/<[^>]+>/g, '');
  s = decode(s);
  s = s.split('\n').map((l) => l.replace(/[ \t]+/g, ' ').trim()).join('\n');
  return s.replace(/\n{3,}/g, '\n\n').trim();
}

/* -- what is already on the shelves --------------------------------------- */

const existing = [];
for (const file of readdirSync(LIBRARY)) {
  const raw = readFileSync(join(LIBRARY, file), 'utf8');
  existing.push({
    call: raw.match(/^call_number:\s*(.+)$/m)?.[1]?.trim() ?? '',
    school: raw.match(/^school:\s*(.+)$/m)?.[1]?.trim() ?? '',
  });
}

/** The highest accession number used on each shelf, so new ones continue it. */
const highest = new Map(SHELVES.map((s) => [s, 0]));
for (const b of existing) {
  const n = Number(/-(\d+)$/.exec(b.call)?.[1] ?? 0);
  if (highest.has(b.school)) highest.set(b.school, Math.max(highest.get(b.school), n));
}

const sealed = new Set(Object.keys(JSON.parse(readFileSync(RESTRICTED, 'utf8')).titles));

/* -- fetch and write ------------------------------------------------------ */

const wanted = JSON.parse(readFileSync(process.argv[2], 'utf8'));
const written = [];
const failed = [];

for (const title of wanted) {
  const shelf = SHELF_OF[title];
  if (shelf === undefined) { failed.push(`${title}: no shelf assigned`); continue; }

  /*
   * `Skyrim:Beggar` is a disambiguation page; the volume is at
   * `Skyrim:Beggar (book)`. The suffix belongs to the page name and not to the
   * book, so it is tried as a fallback and never appears in the title.
   */
  let text = null;
  for (const page of [`Skyrim:${title}`, `Skyrim:${title} (book)`]) {
    try {
      const got = await api({ action: 'parse', page, prop: 'text', format: 'json', formatversion: '2' });
      text = bookText(got.parse.text);
      if (text !== null && text.length >= 200) break;
    } catch { /* try the next name */ }
  }

  // A book with no text is a failed fetch wearing a book's clothes. Refuse it
  // rather than commit an empty volume that looks fine in the catalogue.
  if (text === null || text.length < 200) {
    failed.push(`${title}: no readable body (${text === null ? 'no book div' : text.length + ' chars'})`);
    continue;
  }

  const author = /^by\s+(.+)$/im.exec(text.split('\n').slice(0, 6).join('\n'))?.[1]?.trim() ?? 'Anonymous';
  const tier = ROMAN[SHELVES.indexOf(shelf)];
  const next = highest.get(shelf) + 1;
  highest.set(shelf, next);
  const call = `AR-${tier}-${String(next).padStart(3, '0')}`;

  const front = [
    '---',
    `call_number: ${call}`,
    `title: ${title}`,
    `author: ${author}`,
    `school: ${shelf}`,
    `restricted: ${sealed.has(title)}`,
    'source: supplied by the College',
    '---',
  ].join('\n');

  writeFileSync(join(LIBRARY, `${call}.md`), `${front}\n${text}\n`, 'utf8');
  written.push({ call, title, author, shelf, chars: text.length, sealed: sealed.has(title) });
  process.stdout.write(`  ${call}  ${title}\n`);
}

/* -- one migration -------------------------------------------------------- */

/*
 * REBUILT FROM THE LIBRARY, not from this run's batch.
 *
 * The first version wrote only the books fetched in that invocation, so the
 * second run — six retries — replaced a migration holding thirty volumes with
 * one holding five, and the other twenty-five would have vanished at the next
 * `db:reset` with nothing to say they had ever been there. Every book not
 * carried by an earlier migration goes in, every time.
 */
const earlier = new Set();
for (const file of readdirSync(MIGRATIONS)) {
  if (!/^00(0[2-9]|1[0-5])_/.test(file)) continue;
  const sql = readFileSync(join(MIGRATIONS, file), 'utf8');
  for (const m of sql.matchAll(/'(AR-[IVX]+-\d{3})'/g)) earlier.add(m[1]);
}

const addenda = [];
for (const file of readdirSync(LIBRARY).sort()) {
  const raw = readFileSync(join(LIBRARY, file), 'utf8');
  const front = /^---\n([\s\S]*?)\n---\n([\s\S]*)$/.exec(raw);
  if (front === null) continue;
  const meta = Object.fromEntries(
    front[1].split('\n').map((l) => [l.slice(0, l.indexOf(':')).trim(), l.slice(l.indexOf(':') + 1).trim()]),
  );
  if (earlier.has(meta.call_number)) continue;
  addenda.push({ ...meta, body: front[2].trim() });
}

const q = (s) => `'${String(s).replace(/'/g, "''")}'`;
const lines = [
  '-- Volumes added after the corpus was written.',
  '--',
  '-- Hand-shaped rather than regenerated: migrations 0002-0012 number every id',
  '-- in one pass, so slotting books into the middle of that sequence would',
  '-- renumber every row after them. These take the next free ids and the',
  '-- catalogue orders by call number, not by id.',
  '--',
  '-- Idempotent on the call number, so a full reseed in either order leaves one',
  '-- row per book.',
  '',
];
for (const b of addenda) {
  lines.push(`-- ${b.call_number}  ${b.title}`);
  lines.push(`DELETE FROM tomes WHERE call_number = ${q(b.call_number)};`);
  lines.push('INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES (');
  lines.push('  (SELECT IFNULL(MAX(id), 0) + 1 FROM tomes),');
  lines.push(`  ${q(b.call_number)}, ${q(b.title)}, ${q(b.author)}, ${q(b.school)},`);
  lines.push(`  ${q(b.body)}, ${b.restricted === 'true' ? 1 : 0}`);
  lines.push(');', '');
}
lines.push('-- External-content FTS: rows inserted behind its back are invisible to');
lines.push('-- MATCH until it is told.');
lines.push("INSERT INTO tomes_fts(tomes_fts) VALUES('rebuild');", '');
writeFileSync(MIGRATION, lines.join('\n'), 'utf8');

console.log(`\n${written.length} fetched this run, ${failed.length} failed`);
if (failed.length > 0) { console.log('\nFAILED:'); for (const f of failed) console.log('  ' + f); }
console.log(`migration carries ${addenda.length} volumes -> ${MIGRATION}`);
