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
function toMatchQuery(raw: string): string | null {
  const tokens = raw.toLowerCase().match(/[\p{L}\p{N}]+/gu) ?? [];
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

  const match = toMatchQuery(raw);
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
   */
  const sql =
    `SELECT t.id, t.call_number, t.title, t.author, t.school, t.restricted,` +
    ` snippet(tomes_fts, 2, ?, ?, '…', 14) AS excerpt,` +
    ` bm25(tomes_fts, 10.0, 4.0, 1.0) AS score` +
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
      hits: results.map((h) => ({ ...h, restricted: h.restricted === 1 })),
    },
    200,
    'public, max-age=30',
  );
});
