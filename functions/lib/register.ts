/**
 * The register of consultation.
 *
 * Ported from the Thalmor archive's `functions/lib/register.ts`, which has been
 * running this exact design in production, with its one dimension removed: that
 * one keeps a per-country tally and shows the provinces, this one keeps a
 * number. Same cookie, same reader test, same refusal to read a count into
 * JavaScript and write it back.
 *
 * WHAT IS STORED IS ONE INTEGER. No address, no user agent, no timestamp, no
 * country, no row per visitor. There is deliberately nothing here that could
 * answer "did this person come back" — a counter that can tell readers apart is
 * a tracker whatever it is called.
 *
 * Pure functions, no `context`, so every rule in here can be reasoned about on
 * its own.
 */

/* -- the cookie ----------------------------------------------------------- */

export const CONSULT_COOKIE_NAME = 'arcanaeum_consulted';

/** One day. The register records a reader once a day, not once ever. */
export const CONSULT_COOKIE_MAX_AGE = 60 * 60 * 24;

/** The one URL the browser will ever send the cookie to. */
export const ENTRY_PATH = '/api/register/entry';

/**
 * The dedupe cookie.
 *
 * THE VALUE IS THE LITERAL `1`. Not a nonce, not a hash of anything, not a
 * visitor id. Two visits from one browser are indistinguishable from two
 * browsers in everything this archive stores, and that is the point.
 *
 * `Path` IS LOAD-BEARING. Scoped to the single entry URL, the browser never
 * attaches it to `/api/tomes`, `/api/search`, `/api/availability`, the HTML or
 * any asset — so no cached route has to grow a `Vary: Cookie` and no cache key
 * changes. Widening it to `Path=/` would quietly make every `public, max-age`
 * route's caching wrong.
 *
 * `Secure` is set even though local development is plain HTTP: browsers make an
 * explicit exception for `localhost`, so it costs nothing there and is right
 * everywhere else.
 */
export function consultedCookie(): string {
  return (
    `${CONSULT_COOKIE_NAME}=1` +
    `; Path=${ENTRY_PATH}` +
    '; HttpOnly' +
    '; Secure' +
    '; SameSite=Strict' +
    `; Max-Age=${CONSULT_COOKIE_MAX_AGE}`
  );
}

/** Whether a named cookie is present. The value is never inspected. */
export function hasCookie(request: Request, name: string): boolean {
  const header = request.headers.get('cookie');
  if (header === null) return false;
  return header
    .split(';')
    .some((pair) => pair.slice(0, pair.indexOf('=')).trim() === name);
}

/* -- who is asking -------------------------------------------------------- */

/**
 * Whether this looks like a reader's browser rather than a crawler.
 *
 * Judged from headers the browser sets and page script cannot forge:
 *
 *   - POST. Crawlers, link unfurlers and preview fetchers issue GET or HEAD and
 *     never reach the handler at all.
 *   - `Sec-Fetch-Site: same-origin` and `Sec-Fetch-Mode: cors`, both set by the
 *     browser itself and not overridable from script.
 *   - `Origin` equal to our own.
 *
 * None of these is an address or a user agent, and none is retained: they are
 * read, judged and dropped inside one request.
 */
export function isReaderRequest(request: Request): boolean {
  if (request.method !== 'POST') return false;
  if (request.headers.get('sec-fetch-site') !== 'same-origin') return false;
  if (request.headers.get('sec-fetch-mode') !== 'cors') return false;

  const origin = request.headers.get('origin');
  if (origin === null) return false;
  try {
    return new URL(origin).origin === new URL(request.url).origin;
  } catch {
    return false;
  }
}

/* -- the statements ------------------------------------------------------- */

/**
 * THE COUNT IS NEVER READ INTO JS AND WRITTEN BACK.
 *
 * `visits = visits + 1` happens inside the database, which is the entire reason
 * two readers arriving at once cannot lose a count between them. The obvious
 * refactor — read the row, add one, write it — is how this same feature on a
 * key-value store silently drops visits, and it must not be done here.
 *
 * `RETURNING` makes the increment and the read one statement, so the number a
 * reader is shown is the total as committed rather than a second query's guess
 * at it.
 */
export const ENTER_SQL = `
  UPDATE tally SET visits = visits + 1 WHERE id = 1 RETURNING visits
`;

export const COUNT_SQL = 'SELECT visits FROM tally WHERE id = 1';
