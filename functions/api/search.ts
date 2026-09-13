// GET /api/search?q=…&shelf=…&limit=…
//
// The librarian's route. `/api/tomes` returns metadata and deliberately never
// selects `body`, so the prose has never been on the client and no amount of
// filtering there could ever have searched it. A librarian asked for
// "illusion" wants the thirteen books that contain the word, not the one with
// it in the title, so the search happens where the text is.

import { canonicalShelf, SHELVES } from '../../shared/shelves';
import { fail, json, readOnly, type RequestContext } from './_lib';

/** Two characters is the shortest query worth a round trip. */
const MIN_QUERY = 2;
/** Long enough for a title and an author; past that it is not a search. */
const MAX_QUERY = 96;
const DEFAULT_LIMIT = 60;
const MAX_LIMIT = 100;

/**
 * Where a match sits inside the excerpt.
 *
 * SQLite marks the matched run for us, but its markers must not be HTML — the
 * excerpt is user-influenced text on its way to a page, and the renderer in
 * src/lib/markdown.ts escapes for exactly this reason. So the markers are two
 * control characters that cannot occur in the corpus, and the client splits on
 * them and builds elements. Nothing here ever reaches innerHTML.
 */
const OPEN = '\u0001';
const CLOSE = '\u0002';

interface Hit {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
  volume?: string | null;
  restricted: number;
  excerpt: string;
  score: number;
  /** The prose, selected only for books that have `## ` headings in it. */
  body: string | null;
}

/**
 * A `## ` heading line and the text under it, as cut by `sectionsOf`. The
 * heading is part of the text: it is in the index, so it can be what matched.
 */
interface Section {
  heading: string;
  text: string;
  /** Where the heading line begins in the body. */
  start: number;
}

/**
 * A book's text cut at its `## ` headings.
 *
 * Forty-odd volumes on the shelf are really several bound together —
 * "Biography of Barenziah" is three volumes, "The Real Barenziah" five, "2920"
 * twelve — and the seed keeps each one as a single row whose body has a
 * heading per part. Whatever comes before the first heading (a translator's
 * note, an editor's preface) belongs to no part and is dropped here.
 */
function sectionsOf(body: string): Section[] {
  const heads = [...body.matchAll(/^## (.*)$/gmu)];
  return heads.map((m, i) => {
    const start = m.index;
    const end = i + 1 < heads.length ? heads[i + 1].index : body.length;
    return { heading: m[1].trim(), text: body.slice(start, end), start };
  });
}

/**
 * The words in a run of text, roughly as unicode61 with remove_diacritics
 * sees them: lower-cased, accents folded, split at anything that is not a
 * letter or a digit.
 */
function wordsOf(text: string): string[] {
  return (
    text
      .normalize('NFD')
      .replace(/\p{M}+/gu, '')
      .toLowerCase()
      .match(/[\p{L}\p{N}]+/gu) ?? []
  );
}

const romanMap: Record<string, number> = { I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000 };

function romanValue(token: string): number {
  let total = 0;
  for (let i = 0; i < token.length; i++) {
    const here = romanMap[token[i]] ?? 0;
    const next = romanMap[token[i + 1]] ?? 0;
    total += next > here ? -here : here;
  }
  return total;
}

/** Spelled-out numbers the register's own headings use — "Book One" through
 * "Book Eight" and the odd compound like "Book Twenty-One". */
const WORD_NUMBERS: Record<string, number> = {
  one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10,
  eleven: 11, twelve: 12, thirteen: 13, fourteen: 14, fifteen: 15, sixteen: 16,
  seventeen: 17, eighteen: 18, nineteen: 19, twenty: 20, thirty: 30, forty: 40, fifty: 50,
};

function wordToNumber(raw: string): number {
  const parts = raw.toLowerCase().trim().split(/[\s-]+/);
  if (parts.length === 1) return WORD_NUMBERS[parts[0]] ?? NaN;
  if (parts.length === 2) {
    const tens = WORD_NUMBERS[parts[0]];
    const ones = WORD_NUMBERS[parts[1]];
    if (tens >= 20 && tens % 10 === 0 && ones < 10) return tens + ones;
  }
  return NaN;
}

/**
 * A heading reduced to the one vocabulary the shelf shows.
 *
 * "Part 2", "Book One", and "Chapter V" all name the same thing to a reader —
 * a sequence number within this particular book — and the archive's own
 * mixed usage of Part/Book/Chapter/Volume is not something a visitor searching
 * for Kynareth needs to see. Where the heading is not one of these forms
 * (a named interlude, an epilogue), the original heading is kept rather than
 * dropped — see the call site.
 */
function normalizeHeading(heading: string): string | null {
  const match = heading.match(
    /\b(?:volume|vol(?:ume)?\.?|book|chapter|part)\b\s*(?:[.:\-]\s*)?([ivxlcdm]+|\d+|[a-z]+(?:[\s-][a-z]+)?)\b/i,
  );
  if (!match) return null;

  const token = match[1].trim();
  const n = /^[ivxlcdm]+$/i.test(token) ? romanValue(token.toUpperCase())
    : /^\d+$/.test(token) ? Number(token)
    : wordToNumber(token);

  return Number.isFinite(n) ? `Volume ${n}` : null;
}

/**
 * Which parts of a bound volume the match is in.
 *
 * FTS5 answers per row, and a row is the whole book: it can say "Biography of
 * Barenziah" has the word, not that it is Volume Two. So the parts are checked
 * again here, with the same shape of test the MATCH expression asked for —
 * every word present, the last as a prefix — and the ones that pass are named.
 *
 * A WORD THAT MATCHED ON THE SPINE IS NOT ASKED OF THE PARTS. The MATCH runs
 * over title and author as well as body, so "gamboge almalexia" finds the
 * Biography by its author and its text together — and "gamboge" is as true of
 * Volume Three as of Volume One, so it says nothing about which. Only the
 * words the body actually has are required of each part; a query that matched
 * on the spine alone requires nothing, and names nothing.
 *
 * That re-check is an approximation of the tokenizer, and a query whose words
 * fall in different parts passes the row without passing any one part. So the
 * part the excerpt was cut from is always in the answer too: SQLite chose that
 * window because the words are in it, and the excerpt is a verbatim run of the
 * body, which is enough to find it again.
 *
 * ONLY WHEN THE EXCERPT IS A MATCH. A hit on the title or the author alone has
 * nothing in the body to quote, and SQLite hands back the opening of the book
 * instead — an excerpt with no marker in it. That window was not chosen for
 * its words, and reading a part off it would name "Volume One" for every
 * search that found the book by its spine.
 *
 * Nothing for books without headings, and nothing for a book that is one
 * heading over the whole text — "which part?" has no answer there.
 */
function sectionsHit(body: string, excerpt: string, tokens: string[]): string[] {
  const sections = sectionsOf(body);
  if (sections.length < 2) return [];

  const inBody = wordsOf(body);
  const last = tokens[tokens.length - 1];
  const exact = tokens.slice(0, -1).filter((t) => inBody.includes(t));
  const prefixed = inBody.some((w) => w.startsWith(last));
  const hit = sections.map(({ text }) => {
    if (exact.length === 0 && !prefixed) return false;
    const words = wordsOf(text);
    return (
      exact.every((t) => words.includes(t)) && (!prefixed || words.some((w) => w.startsWith(last)))
    );
  });

  // The excerpt is `…` + a run of the body + `…`, with the markers dropped in.
  const run = excerpt.split(OPEN).join('').split(CLOSE).join('').replace(/^…|…$/gu, '');
  const at = excerpt.includes(OPEN) ? body.indexOf(run) : -1;
  if (at >= 0) {
    // The last part that begins before the run; none if the run is preface.
    for (let i = sections.length - 1; i >= 0; i--) {
      if (sections[i].start <= at) {
        hit[i] = true;
        break;
      }
    }
  }

  // Every heading the register writes — Part, Book, Chapter, Volume, roman or
  // spelled out — reduces to "Volume N" here. A heading that isn't one of
  // those forms (a named interlude) is shown as written rather than dropped.
  return sections
    .filter((_, i) => hit[i])
    .map(({ heading }) => normalizeHeading(heading) ?? heading);
}

function volumeCategoryFromQuery(raw: string): string | null {
  const match = raw.match(/\b(?:vol(?:ume)?|book|chapter|part)\b\s*(?:[.:\-]\s*)?([ivxlcdm]+|\d+)/i);
  if (!match) return null;

  const token = match[1].trim();
  if (/^[ivxlcdm]+$/i.test(token)) return `Volume ${romanValue(token.toUpperCase())}`;

  const numeric = Number(token);
  return Number.isFinite(numeric) ? `Volume ${numeric}` : null;
}

/**
 * A typed phrase into an FTS5 MATCH expression.
 *
 * Every token is quoted, which turns FTS5's own operators — `OR`, `NEAR`, `*`,
 * `:`, `-` — back into ordinary words. A librarian typing `NEAR` is looking for
 * the word "near", and an unquoted query is also a way to make the database
 * answer 500 by typing a stray quotation mark.
 *
 * The last token gets a prefix star so the results move while the word is still
 * being typed; the earlier ones are exact, so "night mother" does not also mean
 * "nightingale".
 */
function toMatchQuery(tokens: string[]): string | null {
  if (tokens.length === 0) return null;

  return tokens
    .map((token, i) => (i === tokens.length - 1 ? `"${token}"*` : `"${token}"`))
    .join(' AND ');
}

export const onRequest = readOnly(async ({ request, env }: RequestContext) => {
  const params = new URL(request.url).searchParams;

  const raw = (params.get('q') ?? '').trim();
  if (raw.length < MIN_QUERY) {
    return fail('bad_request', `Ask for at least ${MIN_QUERY} characters.`, 400);
  }
  if (raw.length > MAX_QUERY) {
    return fail('bad_request', `That is longer than a search: ${MAX_QUERY} characters at most.`, 400);
  }

  const tokens = wordsOf(raw);
  const match = toMatchQuery(tokens);
  if (match === null) {
    return fail('bad_request', 'Nothing in that to search for.', 400);
  }

  const shelfParam = params.get('shelf');
  let shelf: string | null = null;
  if (shelfParam !== null && shelfParam !== '') {
    shelf = canonicalShelf(shelfParam);
    if (shelf === null) {
      return fail('bad_request', `No such shelf. The shelves are: ${SHELVES.join(', ')}.`, 400);
    }
  }

  const askedFor = Number(params.get('limit') ?? DEFAULT_LIMIT);
  const limit = Number.isSafeInteger(askedFor)
    ? Math.min(Math.max(askedFor, 1), MAX_LIMIT)
    : DEFAULT_LIMIT;

  const requestedVolume = volumeCategoryFromQuery(raw);

  const sql =
    `SELECT t.id, t.call_number, t.title, t.author, t.school, t.restricted, t.volume,` +
    ` snippet(tomes_fts, 2, ?, ?, '…', 14) AS excerpt,` +
    ` bm25(tomes_fts, 10.0, 4.0, 1.0) AS score,` +
    ` CASE WHEN instr(t.body, '## ') > 0 THEN t.body END AS body` +
    ` FROM tomes_fts` +
    ` JOIN tomes t ON t.id = tomes_fts.rowid` +
    ` WHERE tomes_fts MATCH ?` +
    (requestedVolume === null ? '' : ' AND lower(t.volume) LIKE ?') +
    (shelf === null ? '' : ' AND t.school = ?') +
    ` ORDER BY score LIMIT ?`;

  const binds: unknown[] = [OPEN, CLOSE, match];
  if (requestedVolume !== null) binds.push(`%${requestedVolume}%`);
  if (shelf !== null) binds.push(shelf);
  binds.push(limit);

  let results: Hit[];
  try {
    ({ results } = await env.DB.prepare(sql).bind(...binds).all<Hit>());
  } catch {
    return json({ query: raw, shelf, hits: [], total: 0 }, 200, 'no-store');
  }

  return json(
    {
      query: raw,
      shelf,
      total: results.length,
      truncated: results.length === limit,
      markers: { open: OPEN, close: CLOSE },
      hits: results.map(({ body, ...h }) => ({
        ...h,
        restricted: h.restricted === 1,
        sections: body === null ? [] : sectionsHit(body, h.excerpt, tokens),
      })),
    },
    200,
    'public, max-age=30',
  );
});