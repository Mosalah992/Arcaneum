// Guards every /api/* route.
//
// THIS IS THE BOUNDARY. The passphrase field on the front page is scenery —
// a reader can delete the cookie, edit the bundle or call the routes with curl,
// and none of it gets them a book, because every one of those requests arrives
// here first. Anything not in PUBLIC below needs a valid writ.
//
// IT FAILS CLOSED. A missing secret answers 503 and the archive is unreadable
// until somebody sets it. The alternative — treating "no passphrase configured"
// as "no passphrase required" — means one lost secret silently opens the whole
// archive with nothing on any screen to say so. A gate that fails open is not a
// gate. This one breaks loudly and is fixed with one command.
//
// AND IT REWRITES THE CACHING. /api/tomes answers `public, max-age=60` and
// /api/search `public, max-age=30`; behind a gate a shared edge cache would
// happily hand one of those to the next reader along, cookie or no cookie.
// Every gated response leaves here `private, no-store` with `Vary: Cookie`.

import { GATE_COOKIE_NAME, epochOf, readCookie, readWrit, type GateEnv } from '../lib/gate';

interface MiddlewareContext {
  request: Request;
  env: GateEnv;
  next: () => Promise<Response>;
}

/** The one door that cannot be behind the door. */
const PUBLIC = new Set(['/api/gate']);

function sealed(status: number, message: string): Response {
  return new Response(JSON.stringify({ error: { code: 'sealed', message } }), {
    status,
    headers: {
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'private, no-store',
      'x-content-type-options': 'nosniff',
      'x-frame-options': 'DENY',
      vary: 'Cookie',
    },
  });
}

export const onRequest = async (context: MiddlewareContext): Promise<Response> => {
  const { pathname } = new URL(context.request.url);
  if (PUBLIC.has(pathname)) return context.next();

  const { ARCANAEUM_PASSPHRASE, ARCANAEUM_GATE_SECRET } = context.env;
  if (
    ARCANAEUM_PASSPHRASE === undefined ||
    ARCANAEUM_PASSPHRASE === '' ||
    ARCANAEUM_GATE_SECRET === undefined ||
    ARCANAEUM_GATE_SECRET === ''
  ) {
    return sealed(503, 'The archive is sealed pending the warden’s key.');
  }

  const writ = await readWrit(
    ARCANAEUM_GATE_SECRET,
    epochOf(context.env),
    readCookie(context.request, GATE_COOKIE_NAME),
  );
  if (writ === null) {
    return sealed(401, 'No writ of passage accompanies this request.');
  }

  const upstream = await context.next();
  const response = new Response(upstream.body, upstream);
  response.headers.set('cache-control', 'private, no-store');
  response.headers.set('vary', 'Cookie');
  // `public/_headers` covers static assets only — Pages does not apply it to a
  // Function's response — so the two headers that mean anything on JSON are set
  // here instead. A scan of the shell alone will not show this gap.
  response.headers.set('x-content-type-options', 'nosniff');
  response.headers.set('x-frame-options', 'DENY');
  return response;
};
