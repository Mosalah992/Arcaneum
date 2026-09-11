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
const OPEN = '';
const CLOSE = '';

interface Hit {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
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

  return sections.filter((_, i) => hit[i]).map(({ heading }) => heading);
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

  /*
   * bm25 weights title and author above body.
   *
   * Its score is negative and more negative is better, so ascending order is
   * best-first. Without the weights a book that says "illusion" once in
   * passing outranks one called "On the Courtesy of Illusions", because the
   * short field it appears in is not otherwise privileged.
   *
   * The excerpt is taken from the body (column 2). Where the match is only in
   * the title, there is nothing in the body to quote and SQLite returns the
   * opening of the book, which is the right thing to show anyway.
   *
   * THE EXCERPT IS THE ONE PLACE A BOOK'S TEXT STILL LEAVES THE SERVER, and it
   * is worth being explicit about that. The reader was removed so that a
   * librarian cannot sit and read the volumes they are cataloguing; this hands
   * back about fourteen tokens around a match, which is a card catalogue's
   * keyword-in-context and not a book — but a patient person with a wordlist
   * could walk a volume out of it a phrase at a time. It stays because
   * searching inside the volumes is the feature the archive was asked for and
   * the excerpt is what makes a hit legible. Dropping `snippet(...)` from this
   * SELECT and the `excerpt` field from the client's `Hit` is the whole change
   * if that trade is ever judged the wrong way round.
   */
  const sql =
    `SELECT t.id, t.call_number, t.title, t.author, t.school, t.restricted,` +
    ` snippet(tomes_fts, 2, ?, ?, '…', 14) AS excerpt,` +
    ` bm25(tomes_fts, 10.0, 4.0, 1.0) AS score,` +
    // The body comes back only where it has parts to name, so the forty-odd
    // bound volumes cost a round trip of their prose and the other two hundred
    // cost nothing. It never leaves this function.
    ` CASE WHEN instr(t.body, '## ') > 0 THEN t.body END AS body` +
    ` FROM tomes_fts` +
    ` JOIN tomes t ON t.id = tomes_fts.rowid` +
    // Sealed volumes are searched with the rest of them: they are listed on
    // the shelf now, and a search that quietly skipped five of the books the
    // College holds would be a worse tool than one that admits to them.
    ` WHERE tomes_fts MATCH ?` +
    (shelf === null ? '' : ' AND t.school = ?') +
    ` ORDER BY score LIMIT ?`;

  const binds: unknown[] = [OPEN, CLOSE, match];
  if (shelf !== null) binds.push(shelf);
  binds.push(limit);

  let results: Hit[];
  try {
    ({ results } = await env.DB.prepare(sql).bind(...binds).all<Hit>());
  } catch {
    // A MATCH expression FTS5 will not parse is the visitor's typing, not a
    // fault: answer "nothing found" rather than 500 at somebody mid-word.
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
