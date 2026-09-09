// POST /api/register/entry — a reader is entered in the register.
//
// THE ONE ROUTE ON THIS SITE THAT WRITES ANYTHING. Every other route is wrapped
// in `readOnly()` and refuses a POST; this one takes no body, no parameters and
// no identifier, and the whole of its effect is `visits = visits + 1`.
//
// WHY THE PAGE CALLS IT RATHER THAN A ROUTE COUNTING ITSELF. The obvious place
// to count is inside /api/tomes, and it is the wrong one twice over: that route
// is `public, max-age=60`, so the Function usually never runs and most readers
// would go uncounted — and a Set-Cookie on a publicly cached response can be
// handed to the NEXT reader by the cache, after which nobody is ever counted
// again.
//
// EVERY FAILURE IS A 204. Already counted, not a browser, no database, database
// broken, migration unapplied — all of them answer the same way. That is partly
// so the client has one simple thing to do, and partly so a prober cannot use
// the status code to learn whether they have been recorded, whether the checks
// caught them, or whether there is a database behind this at all.

import type { Env, RequestContext } from '../_lib';
import {
  CONSULT_COOKIE_NAME,
  ENTER_SQL,
  consultedCookie,
  hasCookie,
  isReaderRequest,
} from '../../lib/register';

/** Nothing was recorded, and the caller is told nothing about why. */
const silent = (): Response =>
  new Response(null, {
    status: 204,
    headers: { 'cache-control': 'private, no-store', vary: 'Cookie' },
  });

export const onRequest = async (ctx: RequestContext): Promise<Response> => {
  const { request } = ctx;

  if (request.method !== 'POST') {
    return new Response(
      JSON.stringify({
        error: { code: 'method_not_allowed', message: 'Readers are entered here, not listed.' },
      }),
      {
        status: 405,
        headers: {
          'content-type': 'application/json; charset=utf-8',
          'cache-control': 'private, no-store',
          allow: 'POST',
        },
      },
    );
  }

  if (!isReaderRequest(request)) return silent();

  // Already entered today. This returns BEFORE touching D1 — repeat traffic is
  // the common case and it should cost the database nothing.
  if (hasCookie(request, CONSULT_COOKIE_NAME)) return silent();

  const env = ctx.env as Env;

  try {
    // Incremented IN SQL and returned by the same statement. Never read into
    // JavaScript and written back — that is what makes two readers arriving
    // together safe, and it is the one thing here not to refactor.
    const row = await env.DB.prepare(ENTER_SQL).first<{ visits: number }>();
    if (row === null) return silent();

    return new Response(JSON.stringify({ visits: row.visits }), {
      status: 200,
      headers: {
        'content-type': 'application/json; charset=utf-8',
        'cache-control': 'private, no-store',
        // No cache stores a POST, but the dependency is real and saying so
        // costs nothing.
        vary: 'Cookie',
        'set-cookie': consultedCookie(),
      },
    });
  } catch {
    // An unapplied migration is the likeliest cause. No cookie is set, so the
    // reader is simply counted on their next visit instead.
    return silent();
  }
};
