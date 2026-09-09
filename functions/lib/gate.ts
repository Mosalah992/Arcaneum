/**
 * The warden's word, and the writ it buys.
 *
 * PORTED FROM THE THALMOR ARCHIVE's `functions/lib/session.ts`, which ran this
 * design in production before its registers were made public. Shared passphrase
 * in, HMAC-signed cookie out, every `/api/*` route guarded by the middleware
 * beside this file. WebCrypto only, so it runs unchanged on Pages.
 *
 * THE GATE PAGE IS SCENERY. The boundary is `functions/api/_middleware.ts` and
 * nothing else: a reader can delete a cookie, edit the JavaScript, or call the
 * routes with curl, and none of that gets them a book. What the front page does
 * is ask nicely and hand back a writ.
 *
 * WHAT IT DOES AND DOES NOT COVER. It covers the content — every book, the
 * search, the register, the counter. It does NOT cover the shell: the HTML, the
 * bundle, the fonts and the artwork are served by Pages' own asset pipeline and
 * stay public, because putting a Function in front of every asset would cost
 * the edge cache on all of them. Somebody without the word can therefore see an
 * empty terminal and nothing whatever to read, which is the shape of gate this
 * archive wants. `robots.txt` still refuses indexing on top of it.
 *
 * TWO SECRETS, NOT ONE, and the separation is deliberate:
 *
 *   ARCANAEUM_PASSPHRASE   the word a reader types. Memorable, shared, and
 *                          therefore low-entropy — it is compared against, and
 *                          it is never used as a key.
 *   ARCANAEUM_GATE_SECRET  32 random bytes that sign the writ. Nobody types it
 *                          and nobody needs to know it.
 *
 * Signing with the passphrase would make a guessable word into the key that
 * mints admissions, and would mean changing the word forged every writ already
 * issued. Keeping them apart means the word can be changed without logging
 * anybody out, and everybody can be logged out — by bumping
 * `ARCANAEUM_GATE_EPOCH` — without changing the word.
 */

const enc = new TextEncoder();

export const GATE_COOKIE_NAME = 'arcanaeum_writ';

/** One week. Long enough that a reader is not asked twice in an evening. */
export const WRIT_TTL_SECONDS = 60 * 60 * 24 * 7;

/**
 * What a writ opens, written into the signed body and therefore covered by the
 * MAC along with everything else. One door today; named anyway, so a writ
 * minted for some later second door cannot be replayed into this one.
 */
const SCOPE = 'arcanaeum';

export interface GateEnv {
  ARCANAEUM_PASSPHRASE?: string;
  ARCANAEUM_GATE_SECRET?: string;
  /** Bump to invalidate every writ ever issued. Defaults to 1. */
  ARCANAEUM_GATE_EPOCH?: string;
}

export interface Writ {
  /** Rotation epoch. */
  e: number;
  /** Expiry, seconds since the Unix epoch. */
  exp: number;
  s: string;
}

/* -- base64url ------------------------------------------------------------ */

function b64urlEncode(bytes: Uint8Array): string {
  let s = '';
  for (const b of bytes) s += String.fromCharCode(b);
  return btoa(s).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}

function b64urlDecode(text: string): Uint8Array {
  const padded = text.replace(/-/g, '+').replace(/_/g, '/');
  const raw = atob(padded + '='.repeat((4 - (padded.length % 4)) % 4));
  return Uint8Array.from(raw, (c) => c.charCodeAt(0));
}

/* -- the signature -------------------------------------------------------- */

async function mac(secret: string, message: string): Promise<Uint8Array> {
  const key = await crypto.subtle.importKey(
    'raw',
    enc.encode(secret),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  return new Uint8Array(await crypto.subtle.sign('HMAC', key, enc.encode(message)));
}

/** Length-independent comparison. Both inputs are fixed-width MACs. */
function constantTimeEqual(a: Uint8Array, b: Uint8Array): boolean {
  if (a.length !== b.length) return false;
  let diff = 0;
  for (let i = 0; i < a.length; i++) diff |= (a[i] ?? 0) ^ (b[i] ?? 0);
  return diff === 0;
}

/**
 * Compare two secrets without leaking length or content through timing.
 *
 * BOTH SIDES GO THROUGH HMAC FIRST, so the comparison is over fixed-width
 * digests rather than the raw words. A plain `===` on two strings returns as
 * soon as they differ, and the time it takes says how many leading characters
 * were right — which is enough to walk a passphrase out one letter at a time.
 */
export async function secretsMatch(
  secret: string,
  offered: string,
  expected: string,
): Promise<boolean> {
  const [a, b] = await Promise.all([mac(secret, offered), mac(secret, expected)]);
  return constantTimeEqual(a, b);
}

/* -- the writ ------------------------------------------------------------- */

export async function issueWrit(secret: string, epoch: number): Promise<string> {
  const writ: Writ = {
    e: epoch,
    exp: Math.floor(Date.now() / 1000) + WRIT_TTL_SECONDS,
    s: SCOPE,
  };
  const body = b64urlEncode(enc.encode(JSON.stringify(writ)));
  return `${body}.${b64urlEncode(await mac(secret, body))}`;
}

export async function readWrit(
  secret: string,
  epoch: number,
  token: string | null,
): Promise<Writ | null> {
  if (token === null || token === '') return null;

  const dot = token.indexOf('.');
  if (dot < 1) return null;

  const body = token.slice(0, dot);
  const signature = token.slice(dot + 1);

  let offered: Uint8Array;
  try {
    offered = b64urlDecode(signature);
  } catch {
    return null;
  }

  // The signature is checked BEFORE the body is parsed. Nothing inside an
  // unverified token is allowed to steer anything, not even a JSON parser.
  if (!constantTimeEqual(offered, await mac(secret, body))) return null;

  let writ: Writ;
  try {
    writ = JSON.parse(new TextDecoder().decode(b64urlDecode(body))) as Writ;
  } catch {
    return null;
  }

  if (writ.e !== epoch) return null; // rotated out
  if (writ.exp < Math.floor(Date.now() / 1000)) return null;
  // No default: a token with no scope is not an old friend, it is a refusal.
  if (writ.s !== SCOPE) return null;

  return writ;
}

/* -- the cookie ----------------------------------------------------------- */

export function readCookie(request: Request, name: string): string | null {
  const header = request.headers.get('cookie');
  if (header === null) return null;
  for (const part of header.split(';')) {
    const at = part.indexOf('=');
    if (at < 0) continue;
    if (part.slice(0, at).trim() === name) return part.slice(at + 1).trim();
  }
  return null;
}

/**
 * `Path=/` because the writ has to ride every `/api/*` request, and
 * `SameSite=Lax` rather than Strict so a reader following a link to a volume
 * from Discord arrives already admitted rather than at the door again.
 *
 * `Max-Age` matches the life of the writ inside. They are separate numbers —
 * the cookie's is enforced by the browser, the writ's by us — and letting them
 * drift only means a reader keeps handing over something already refused.
 */
export function writCookie(token: string): string {
  return [
    `${GATE_COOKIE_NAME}=${token}`,
    'Path=/',
    'HttpOnly',
    'Secure',
    'SameSite=Lax',
    `Max-Age=${WRIT_TTL_SECONDS}`,
  ].join('; ');
}

/** The epoch, as a number, defaulting to 1 when unset or unreadable. */
export function epochOf(env: GateEnv): number {
  const raw = Number(env.ARCANAEUM_GATE_EPOCH ?? '1');
  return Number.isFinite(raw) ? raw : 1;
}
