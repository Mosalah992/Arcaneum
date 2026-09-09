/**
 * What the College actually holds, read from its own register.
 *
 * ONE MODULE IS THE WHOLE SEAM. Everything Google-shaped lives here: the
 * service-account JWT, the batch read, and the arithmetic that turns loan rows
 * into "is there a copy on the shelf". The route above it and the chips in the
 * catalogue know nothing but the shape this returns.
 *
 * READ-ONLY, and minted with the readonly scope, so a bug in this archive
 * cannot disturb the columns the librarians own. The signer is ported from the
 * Thalmor archive's server/gsheets.ts, which has been running this exact flow
 * against this exact service account; it needs no dependency because
 * WebCrypto can sign RS256 on the Cloudflare runtime.
 *
 * AVAILABILITY IS DERIVED, NOT READ. The register's own `Availability` column
 * is empty in every row — the librarians never fill it in, and it would go
 * stale the moment they did. What is real is `Copies` against the open rows in
 * `Book Borrowing` and `In-Library Signouts`, so that is what this counts.
 */

const SCOPE = 'https://www.googleapis.com/auth/spreadsheets.readonly';

/** The sheets, and how far across each one the data goes. */
const RANGES = [
  "'Book Index'!A1:G200",
  "'Book Borrowing'!A1:H400",
  "'In-Library Signouts'!A1:E500",
];

export interface Holding {
  title: string;
  /** Where in the College it stands: R1–R5, L15 for the sealed press. */
  location: string;
  copies: number;
  out: number;
  available: number;
  note: string;
}

export interface Register {
  /** Normalised title -> holding. */
  holdings: Record<string, Holding>;
  /** Titles the register names that the catalogue does not, and vice versa. */
  unmatched: string[];
  fetchedAt: string;
}

export interface SheetsEnv {
  ARCANAEUM_SHEET_ID?: string;
  GOOGLE_SERVICE_ACCOUNT_JSON?: string;
}

/* -- the join key --------------------------------------------------------- */

/**
 * Titles are typed by hand in the register and come off a fan site in the
 * catalogue, so they will never match exactly. Case, punctuation, curly
 * quotation marks and a leading article are all noise; what is left is enough
 * to pair "The Book of Daedra" with "book of daedra".
 *
 * Deliberately NOT clever. Fuzzy matching would pair things that are not the
 * same book and there would be no way to see that it had, whereas an
 * unmatched title is visible and a librarian can fix a spelling.
 */
export function normaliseTitle(title: string): string {
  return title
    .toLowerCase()
    .replace(/[‘’“”]/g, "'")
    .replace(/[^a-z0-9' ]+/g, ' ')
    .replace(/^(the|a|an)\s+/, '')
    .replace(/\s+/g, ' ')
    .trim();
}

/* -- the token ------------------------------------------------------------ */

const b64url = (bytes: ArrayBuffer | Uint8Array): string =>
  btoa(String.fromCharCode(...new Uint8Array(bytes)))
    .replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=+$/, '');

const b64urlJSON = (value: unknown): string =>
  b64url(new TextEncoder().encode(JSON.stringify(value)));

function pemToPkcs8(pem: string): ArrayBuffer {
  const body = pem.replace(/-----(BEGIN|END) PRIVATE KEY-----/g, '').replace(/\s/g, '');
  const binary = atob(body);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);
  return bytes.buffer;
}

// Isolates are reused between requests, so a module-scope cache saves a token
// exchange on most of them.
let cachedToken: { token: string; expires: number } | null = null;

async function accessToken(env: SheetsEnv): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  if (cachedToken !== null && now < cachedToken.expires - 300) return cachedToken.token;

  const raw = env.GOOGLE_SERVICE_ACCOUNT_JSON;
  if (raw === undefined || raw === '') throw new Error('no service account configured');

  // Strip a UTF-8 BOM picked up when the secret was pasted in.
  const account = JSON.parse(raw.replace(/^﻿/, '').trim()) as {
    client_email: string;
    private_key: string;
    token_uri: string;
  };

  const header = b64urlJSON({ alg: 'RS256', typ: 'JWT' });
  const claims = b64urlJSON({
    iss: account.client_email,
    scope: SCOPE,
    aud: account.token_uri,
    iat: now,
    exp: now + 3600,
  });

  const key = await crypto.subtle.importKey(
    'pkcs8',
    pemToPkcs8(account.private_key),
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const signature = await crypto.subtle.sign(
    'RSASSA-PKCS1-v1_5',
    key,
    new TextEncoder().encode(`${header}.${claims}`),
  );

  const res = await fetch(account.token_uri, {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body:
      `grant_type=${encodeURIComponent('urn:ietf:params:oauth:grant-type:jwt-bearer')}` +
      `&assertion=${header}.${claims}.${b64url(signature)}`,
  });

  const data = (await res.json()) as { access_token?: string; expires_in?: number };
  if (!res.ok || data.access_token === undefined) {
    throw new Error(`token exchange failed (${res.status})`);
  }

  cachedToken = { token: data.access_token, expires: now + (data.expires_in ?? 3600) };
  return cachedToken.token;
}

/* -- the read ------------------------------------------------------------- */

const cell = (row: string[] | undefined, at: number): string => (row?.[at] ?? '').trim();

/** "Returned", "1", "TRUE", "yes" — anything that means the book came back. */
function isClosed(value: string): boolean {
  const v = value.trim().toLowerCase();
  return v === '1' || v === 'true' || v === 'yes' || v === 'y' || v.startsWith('return');
}

export async function readRegister(env: SheetsEnv): Promise<Register> {
  const sheetId = env.ARCANAEUM_SHEET_ID;
  if (sheetId === undefined || sheetId === '') throw new Error('no sheet configured');

  const token = await accessToken(env);
  const query = RANGES.map((r) => `ranges=${encodeURIComponent(r)}`).join('&');
  const res = await fetch(
    `https://sheets.googleapis.com/v4/spreadsheets/${sheetId}/values:batchGet?${query}`,
    { headers: { authorization: `Bearer ${token}` } },
  );
  if (!res.ok) throw new Error(`sheets read failed (${res.status})`);

  const body = (await res.json()) as { valueRanges?: { values?: string[][] }[] };
  const [index, borrowing, signouts] = (body.valueRanges ?? []).map((r) => r.values ?? []);

  const holdings: Record<string, Holding> = {};

  // Book Index: A Title, B Location, C Copies, D Availability, E Volumes,
  // F Note, G On Loan. Row 1 is the header.
  for (const row of (index ?? []).slice(1)) {
    const title = cell(row, 0);
    if (title === '' || title.toLowerCase() === 'title') continue;
    const copies = Number(cell(row, 2)) || 0;
    holdings[normaliseTitle(title)] = {
      title,
      location: cell(row, 1),
      copies,
      out: 0,
      available: copies,
      note: cell(row, 5),
    };
  }

  const unmatched = new Set<string>();
  const takeOut = (title: string): void => {
    if (title === '') return;
    const key = normaliseTitle(title);
    const holding = holdings[key];
    if (holding === undefined) {
      unmatched.add(title);
      return;
    }
    holding.out += 1;
    holding.available = Math.max(0, holding.copies - holding.out);
  };

  // Book Borrowing: B is the book, F the status. The sheet carries section
  // rows that fill only column A, so a row without both is not a loan.
  for (const row of borrowing ?? []) {
    const book = cell(row, 1);
    const status = cell(row, 5);
    if (book === '' || status === '' || book.toLowerCase() === 'book') continue;
    if (!isClosed(status)) takeOut(book);
  }

  // In-Library Signouts: A the book, D whether it came back.
  for (const row of (signouts ?? []).slice(1)) {
    const book = cell(row, 0);
    if (book === '' || Number.isFinite(Number(book))) continue;
    if (!isClosed(cell(row, 3))) takeOut(book);
  }

  return {
    holdings,
    unmatched: [...unmatched].sort(),
    fetchedAt: new Date().toISOString(),
  };
}
