/**
 * Port the Library of Skyrim into content/library/.
 *
 *     node scripts/import-library.mjs [--fresh]
 *
 * Run once; the markdown it writes is committed. `--fresh` ignores the local
 * HTTP cache and re-fetches every page.
 *
 * WHERE THE INDEX COMES FROM. The site is a JavaScript shell — its home page
 * carries no book links at all — and the catalogue lives in a string inside
 * `injector.js` called `arrayfriendlylist`, with the category-to-directory
 * mapping in a chain of `else if`s below it. Both are read from that file
 * rather than transcribed, so the day the site adds a book this script
 * notices and a hand-copied list would not.
 *
 * HAND-ROLLED HTML READING, no new dependency — the same choice the markdown
 * renderer in src/lib/markdown.ts already makes. It is not a general parser
 * and does not pretend to be: it knows the three ids this one site uses, and
 * it THROWS on any page that does not have them rather than importing a book
 * with an empty body. A silent empty import is the failure that would survive
 * review.
 */

import { mkdirSync, readFileSync, writeFileSync, existsSync, rmSync, readdirSync } from 'node:fs';
import { join } from 'node:path';

const ORIGIN = 'https://skyrimbooksproj.web.app';
const OUT_DIR = join('content', 'library');
const CACHE = join(
  process.env.TEMP ?? '.',
  'arcanaeum-library-cache',
);

const FRESH = process.argv.includes('--fresh');

/**
 * The sealed shelf, read from content/restricted.json rather than decided here.
 *
 * Kept out of the script so that re-running the import does not quietly unseal
 * a book, and so the list can be compared against the College's own register
 * without reading code.
 */
const RESTRICTED = JSON.parse(readFileSync(join('content', 'restricted.json'), 'utf8')).titles;

/** How many pages to have in flight. Politeness, not throughput. */
const CONCURRENCY = 4;

/**
 * The shelves, in the order the source lists them, with the directory each
 * one lives under. The directory names are NOT derived from the shelf names —
 * the source drops the "and" from two of them (`history-lore`,
 * `religion-prophecy`) — so they are taken from injector.js and checked
 * against it on every run.
 */
const SHELVES = [
  { name: 'Biographies', heading: 'Biographies:', dir: 'biographies' },
  { name: 'Faction Books', heading: 'Faction Books:', dir: 'faction-books' },
  { name: 'Fiction', heading: 'Fiction:', dir: 'fiction' },
  { name: 'History & Lore', heading: 'History and Lore:', dir: 'history-lore' },
  { name: 'Instruction & Research', heading: 'Instruction and Research:', dir: 'instruction-research' },
  { name: 'Journals & Logs', heading: 'Journals and Logs:', dir: 'journals-logs' },
  { name: 'Notes & Letters', heading: 'Notes and Letters:', dir: 'notes-letters' },
  { name: 'Plays, Poetry & Riddles', heading: 'Plays, Poetry, and Riddles:', dir: 'plays-poetry-riddles' },
  { name: 'Politics & Law', heading: 'Politics and Law:', dir: 'politics-law' },
  { name: 'Religion & Prophecy', heading: 'Religion and Prophecy:', dir: 'religion-prophecy' },
  { name: 'Travel', heading: 'Travel:', dir: 'travel' },
];

const ROMAN = ['', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI'];

/**
 * Catalogue entries with no page behind them.
 *
 * The source's own catalogue is wrong here, not ours: it lists "Herbane's
 * Bestiary" and "Automatons, Hagravens, Ice Wraiths" as two entries when they
 * are one book, and its own link for the first of them 404s exactly as ours
 * did. The second entry is the real page and its <h1> carries the whole title,
 * so nothing is lost by dropping the fragment.
 *
 * Named individually and on purpose. Skipping 404s as a class would let a
 * genuine breakage — the site moving a directory, say — pass as normal.
 */
const KNOWN_MISSING = new Map([
  ['Herbane’s Bestiary', 'a catalogue fragment; the book is listed again as "Automatons, Hagravens, Ice Wraiths"'],
]);

/** The source's own slug function, copied exactly. Do not improve it. */
function urlify(str) {
  return str.toLowerCase().replace(/[^a-z0-9\s]/g, '').replace(/\s+/g, '-');
}

/* -- fetching ------------------------------------------------------------- */

mkdirSync(CACHE, { recursive: true });

async function get(path) {
  const cached = join(CACHE, urlify(path) || 'index');
  if (!FRESH && existsSync(cached)) return readFileSync(cached, 'utf8');

  const res = await fetch(`${ORIGIN}/${path}`, {
    headers: { 'user-agent': 'Arcanaeum-import/1.0 (one-time port; contact via repo)' },
  });
  if (!res.ok) throw new Error(`${res.status} for /${path}`);
  const text = await res.text();
  writeFileSync(cached, text, 'utf8');
  return text;
}

/* -- HTML ----------------------------------------------------------------- */

const ENTITIES = {
  amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' ',
  rsquo: '’', lsquo: '‘', ldquo: '“', rdquo: '”',
  mdash: '—', ndash: '–', hellip: '…', eacute: 'é',
  darr: '↓', shy: '',
};

function decode(text) {
  return text
    .replace(/&#x([0-9a-fA-F]+);/g, (_, h) => String.fromCodePoint(parseInt(h, 16)))
    .replace(/&#(\d+);/g, (_, d) => String.fromCodePoint(Number(d)))
    .replace(/&([a-zA-Z]+);/g, (m, name) => (name in ENTITIES ? ENTITIES[name] : m));
}

/**
 * The inner HTML of `<div id="...">`, found by counting div depth.
 *
 * Regex to the closing tag would stop at the first `</div>`, which for
 * `#bookcontent` is whatever the first nested div happens to be.
 */
function sliceById(html, id) {
  const open = html.search(new RegExp(`<div[^>]*id=["']${id}["']`));
  if (open === -1) return null;
  const start = html.indexOf('>', open) + 1;

  let depth = 1;
  let at = start;
  const tag = /<\/?div\b/gi;
  tag.lastIndex = start;
  for (let m = tag.exec(html); m !== null; m = tag.exec(html)) {
    depth += m[0][1] === '/' ? -1 : 1;
    if (depth === 0) {
      at = m.index;
      break;
    }
  }
  return html.slice(start, at);
}

// `<br>` becomes a space before tags are dropped. Without that, an author set
// as "Wapna Neustra<br>Praceptor Emeritus" imports as one run-together word.
const strip = (html) =>
  decode(html.replace(/<br\s*\/?>/gi, ' ').replace(/<[^>]*>/g, ''))
    .replace(/\s+/g, ' ')
    .trim();

/**
 * The site's markup into this project's markdown dialect.
 *
 * `##` for both h1 and h2 — the reader gives `##` its one heading style, and a
 * book's internal "Volume One" is a heading of that same rank whichever tag
 * the source reached for.
 */
function toMarkdown(html, report) {
  const blocks = [];

  // Anything not inside a block tag would be silently dropped, so the source's
  // bare `<br>`-separated runs are turned into paragraphs first.
  const normalised = html
    .replace(/<br\s*\/?>\s*<br\s*\/?>/gi, '</p><p>')
    .replace(/<br\s*\/?>/gi, '</p><p>');

  for (const m of normalised.matchAll(/<(h1|h2|h3|p|div)\b[^>]*>([\s\S]*?)<\/\1>/gi)) {
    const tag = m[1].toLowerCase();
    let inner = m[2];

    for (const img of inner.matchAll(/<img[^>]*src=["']([^"']+)["'][^>]*>/gi)) {
      report.images.push(img[1]);
    }
    inner = inner.replace(/<img[^>]*>/gi, '');

    inner = inner
      .replace(/<(i|em)\b[^>]*>([\s\S]*?)<\/\1>/gi, (_, __, t) => {
        const inside = strip(t);
        return inside === '' ? '' : `*${inside}*`;
      })
      .replace(/<(b|strong)\b[^>]*>([\s\S]*?)<\/\1>/gi, (_, __, t) => {
        const inside = strip(t);
        return inside === '' ? '' : `**${inside}**`;
      });

    const text = decode(inner.replace(/<[^>]*>/g, '')).replace(/[ \t]+/g, ' ').trim();
    if (text === '') continue;

    blocks.push(tag === 'h1' || tag === 'h2' || tag === 'h3' ? `## ${text}` : text);
  }

  return blocks.join('\n\n');
}

/* -- the index ------------------------------------------------------------ */

async function readIndex() {
  const js = await get('injector.js');

  const listed = js.match(/var arrayfriendlylist\s*=\s*"([\s\S]*?)"/);
  if (listed === null) throw new Error('injector.js: arrayfriendlylist not found — the source site changed shape');
  const entries = decode(listed[1]).split('; ').map((s) => s.trim()).filter(Boolean);

  // Check our directory mapping against the source's own, so a renamed folder
  // is a loud failure here rather than 40 quiet 404s later.
  for (const shelf of SHELVES) {
    if (!js.includes(`"${shelf.dir}"`)) {
      throw new Error(`injector.js no longer mentions the directory "${shelf.dir}"`);
    }
    if (!entries.includes(shelf.heading)) {
      throw new Error(`the catalogue no longer contains the heading "${shelf.heading}"`);
    }
  }

  const books = [];
  const skipped = [];
  let shelf = null;
  for (const entry of entries) {
    const heading = SHELVES.find((s) => s.heading === entry);
    if (heading !== undefined) {
      shelf = heading;
      continue;
    }
    if (entry.endsWith(':')) throw new Error(`unmapped catalogue heading: ${entry}`);
    if (shelf === null) throw new Error(`title before any heading: ${entry}`);
    if (KNOWN_MISSING.has(entry)) {
      skipped.push(`${entry} — ${KNOWN_MISSING.get(entry)}`);
      continue;
    }
    books.push({ shelf, title: entry });
  }

  for (const line of skipped) console.log(`  skipping ${line}`);
  if (skipped.length !== KNOWN_MISSING.size) {
    throw new Error('a catalogue entry listed in KNOWN_MISSING is no longer there — re-check the exception');
  }
  return books;
}

/* -- one book ------------------------------------------------------------- */

async function readBook(book, index) {
  // Without the .html the server answers directly; with it, it answers 301.
  const path = `books/${book.shelf.dir}/${urlify(book.title)}`;
  const html = await get(path);

  const info = sliceById(html, 'bookinfo');
  const content = sliceById(html, 'bookcontent');
  if (info === null) throw new Error(`${path}: no #bookinfo`);
  if (content === null) throw new Error(`${path}: no #bookcontent`);

  const title = strip(info.match(/<h1\b[^>]*>([\s\S]*?)<\/h1>/i)?.[1] ?? '');
  if (title === '') throw new Error(`${path}: no title in #bookinfo`);

  // Authors appear as "by X", as a bare name, or not at all.
  const credited = strip(info.match(/<h2\b[^>]*>([\s\S]*?)<\/h2>/i)?.[1] ?? '');
  const author = credited === '' ? 'Anonymous' : credited.replace(/^by\s+/i, '').trim();

  const report = { images: [] };
  const body = toMarkdown(content, report);
  if (body.length < 40) throw new Error(`${path}: body is ${body.length} characters — refusing to import an empty book`);

  const tier = SHELVES.indexOf(book.shelf) + 1;
  return {
    restricted: Object.prototype.hasOwnProperty.call(RESTRICTED, title),
    call_number: `AR-${ROMAN[tier]}-${String(index).padStart(3, '0')}`,
    title,
    author: author === '' ? 'Anonymous' : author,
    shelf: book.shelf.name,
    body,
    source: `${ORIGIN}/${path}`,
    images: report.images,
  };
}

/* -- run ------------------------------------------------------------------ */

async function main() {
  const books = await readIndex();
  console.log(`catalogue: ${books.length} titles across ${SHELVES.length} shelves`);

  const counts = new Map();
  const queue = books.map((book) => {
    const next = (counts.get(book.shelf.name) ?? 0) + 1;
    counts.set(book.shelf.name, next);
    return { book, position: next };
  });

  const done = [];
  const failed = [];
  let cursor = 0;

  async function worker() {
    for (;;) {
      const mine = cursor++;
      if (mine >= queue.length) return;
      const { book, position } = queue[mine];
      try {
        done.push(await readBook(book, position));
      } catch (err) {
        failed.push(`${book.shelf.name} / ${book.title}: ${err.message}`);
      }
      if (done.length % 25 === 0) console.log(`  ${done.length}/${queue.length}`);
    }
  }

  await Promise.all(Array.from({ length: CONCURRENCY }, worker));

  if (failed.length > 0) {
    console.error(`\n${failed.length} FAILED:`);
    for (const line of failed) console.error(`  ${line}`);
    throw new Error('refusing to write a partial library');
  }

  rmSync(OUT_DIR, { recursive: true, force: true });
  mkdirSync(OUT_DIR, { recursive: true });

  done.sort((a, b) => a.call_number.localeCompare(b.call_number));
  for (const book of done) {
    const frontmatter = [
      '---',
      `call_number: ${book.call_number}`,
      `title: ${book.title}`,
      `author: ${book.author}`,
      `school: ${book.shelf}`,
      `restricted: ${book.restricted ? 'true' : 'false'}`,
      `source: ${book.source}`,
      '---',
    ].join('\n');
    writeFileSync(join(OUT_DIR, `${book.call_number}.md`), `${frontmatter}\n${book.body}\n`, 'utf8');
  }

  const sealed = done.filter((b) => b.restricted);
  const unmatched = Object.keys(RESTRICTED).filter(
    (t) => !done.some((b) => b.title === t),
  );

  const withImages = done.filter((b) => b.images.length > 0);
  const bytes = done.reduce((n, b) => n + b.body.length, 0);
  const longest = done.reduce((a, b) => (b.body.length > a.body.length ? b : a));

  console.log(`\nwrote ${done.length} books to ${OUT_DIR}`);
  console.log(`  ${(bytes / 1024).toFixed(0)} KB of prose, ${Math.round(bytes / done.length)} average`);
  console.log(`  longest: ${longest.title} (${(longest.body.length / 1024).toFixed(0)} KB)`);
  for (const [shelf, n] of counts) console.log(`  ${String(n).padStart(3)}  ${shelf}`);

  console.log(`
${sealed.length} sealed: ${sealed.map((b) => b.call_number).join(', ')}`);
  if (unmatched.length > 0) {
    console.log(`${unmatched.length} on the register but not in this corpus:`);
    for (const t of unmatched) console.log(`  ${t}`);
  }

  if (withImages.length > 0) {
    console.log(`\n${withImages.length} books carry an image, dropped and to be listed in ASSETS.md:`);
    for (const b of withImages) console.log(`  ${b.call_number}  ${b.title}  ${b.images.join(' ')}`);
  }
}

main().catch((err) => {
  console.error(`\nimport failed: ${err.message}`);
  process.exitCode = 1;
});
