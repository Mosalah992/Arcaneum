// GET  /api/gate — is this reader already admitted?
// POST /api/gate — the word, for a writ.
//
// The one route outside the middleware, because it is the door. It is also the
// only route besides the counter that accepts a POST.
//
// WHAT IT WILL NOT TELL YOU. A refusal says the word was wrong and nothing
// else: not how long the right one is, not how close this one came, not whether
// a passphrase is configured at all beyond the 503 that a sealed archive
// answers with anyway. The comparison itself is over HMAC digests rather than
// the raw strings, so its timing does not say how many leading characters were
// right — see `secretsMatch` in ../lib/gate.ts.
//
// NO RATE LIMIT, and that is a real gap rather than an oversight. A shared word
// against an unthrottled endpoint can be guessed at as fast as the network
// allows. The mitigations are that the word is chosen by the College rather
// than by a user, that there is nothing behind it worth an attack — 249
// published Bethesda books — and that Cloudflare's own protections sit in
// front. If this ever guards something that matters, it needs a limiter first.

import { json } from './_lib';
import {
  GATE_COOKIE_NAME,
  epochOf,
  issueWrit,
  readCookie,
  readWrit,
  secretsMatch,
  writCookie,
  type GateEnv,
} from '../lib/gate';

interface GateContext {
  request: Request;
  env: GateEnv;
}

/** Never cached, never shared. The answer is about one reader's cookie. */
const PRIVATE = 'private, no-store';

const reply = (body: unknown, status = 200, cookie?: string): Response => {
  const headers: Record<string, string> = {
    'content-type': 'application/json; charset=utf-8',
    'cache-control': PRIVATE,
    // The door is outside the middleware, so it sets its own. See the note
    // there: `public/_headers` does not reach a Function's response.
    'x-content-type-options': 'nosniff',
    'x-frame-options': 'DENY',
    vary: 'Cookie',
  };
  if (cookie !== undefined) headers['set-cookie'] = cookie;
  return new Response(JSON.stringify(body), { status, headers });
};

export const onRequest = async (context: GateContext): Promise<Response> => {
  const { request, env } = context;
  const passphrase = env.ARCANAEUM_PASSPHRASE ?? '';
  const secret = env.ARCANAEUM_GATE_SECRET ?? '';
  const configured = passphrase !== '' && secret !== '';

  if (request.method === 'GET' || request.method === 'HEAD') {
    if (!configured) return reply({ configured: false, open: false }, 503);
    const writ = await readWrit(
      secret,
      epochOf(env),
      readCookie(request, GATE_COOKIE_NAME),
    );
    return reply({ configured: true, open: writ !== null });
  }

  if (request.method !== 'POST') {
    const res = json({ error: { code: 'method_not_allowed', message: 'The door takes a word.' } }, 405, PRIVATE);
    res.headers.set('allow', 'GET, POST');
    return res;
  }

  if (!configured) {
    return reply(
      { configured: false, open: false, message: 'The archive is sealed pending the warden’s key.' },
      503,
    );
  }

  let offered = '';
  try {
    const body = (await request.json()) as { passphrase?: unknown };
    if (typeof body.passphrase === 'string') offered = body.passphrase;
  } catch {
    /* an unparseable body is simply a wrong word */
  }

  // Trimmed, and only at the ends. A word typed into a terminal picks up a
  // trailing space from a paste more often than it picks up a wrong letter,
  // and refusing that would be refusing the right word for the wrong reason.
  if (!(await secretsMatch(secret, offered.trim(), passphrase.trim()))) {
    return reply({ configured: true, open: false, message: 'THAT IS NOT THE WORD.' }, 401);
  }

  return reply(
    { configured: true, open: true },
    200,
    writCookie(await issueWrit(secret, epochOf(env))),
  );
};
