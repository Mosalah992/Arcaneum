/** Typed wrappers over the three read-only routes. */

export interface TomeSummary {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
  /** On the College's restricted register, and shelved at L1. */
  restricted: boolean;
}

/** One entry in a volume's colophon: another volume this one points at. */
export interface Refers {
  id: number;
  call_number: string;
  title: string;
  restricted: boolean;
}

export interface Tome extends TomeSummary {
  body: string;
  /** The archive's own cross-references out of this volume. */
  refers: Refers[];
}

export type Resolved = TomeSummary;

export class ArchiveError extends Error {
  constructor(
    readonly status: number,
    readonly code: string,
    message: string,
  ) {
    super(message);
    this.name = 'ArchiveError';
  }
}

async function get<T>(path: string, signal?: AbortSignal): Promise<T> {
  let res: Response;
  try {
    res = await fetch(path, { headers: { accept: 'application/json' }, signal });
  } catch (err) {
    // An aborted request is a keystroke overtaking an older one, not a fault.
    if (err instanceof DOMException && err.name === 'AbortError') {
      throw new ArchiveError(0, 'aborted', 'Superseded.');
    }
    throw new ArchiveError(0, 'offline', 'The archive cannot be reached.');
  }

  let payload: unknown = null;
  try {
    payload = await res.json();
  } catch {
    /* fall through to the status-based message below */
  }

  if (!res.ok) {
    const shape = payload as { error?: { code?: string; message?: string } } | null;
    throw new ArchiveError(
      res.status,
      shape?.error?.code ?? 'internal',
      shape?.error?.message ?? 'The archive did not answer.',
    );
  }
  return payload as T;
}

export async function listTomes(shelf?: string): Promise<TomeSummary[]> {
  const query = shelf ? `?shelf=${encodeURIComponent(shelf)}` : '';
  const { tomes } = await get<{ tomes: TomeSummary[] }>(`/api/tomes${query}`);
  return tomes;
}

export function fetchTome(id: number): Promise<Tome> {
  return get<Tome>(`/api/tomes/${id}`);
}

export interface Hit extends TomeSummary {
  /** A window of the body around the match, with the run marked. */
  excerpt: string;
  score: number;
}

export interface SearchResult {
  query: string;
  shelf: string | null;
  total: number;
  truncated: boolean;
  /** The control characters bracketing the matched run inside `excerpt`. */
  markers: { open: string; close: string };
  hits: Hit[];
}

/**
 * Search the bodies.
 *
 * Separate from `listTomes` on purpose: the listing never carries `body`, so
 * the prose has never been on the client and the old `.includes()` filter could
 * only ever match a spine.
 */
export function searchTomes(
  q: string,
  shelf?: string | null,
  signal?: AbortSignal,
): Promise<SearchResult> {
  const params = new URLSearchParams({ q });
  if (shelf) params.set('shelf', shelf);
  return get<SearchResult>(`/api/search?${params.toString()}`, signal);
}

export function resolveCallNumber(callNumber: string): Promise<Resolved> {
  return get<Resolved>(`/api/resolve/${encodeURIComponent(callNumber)}`);
}

/* -- what the College holds ---------------------------------------------- */

export interface Holding {
  /** The register's own words for it. */
  title: string;
  /** R1–R5 on the open shelves, L1 the restricted press. */
  location: string;
  copies: number;
  out: number;
  available: number;
  /** The librarians' note on a restricted title. Empty otherwise. */
  note: string;
  restricted: boolean;
  /** Register rows folded into this one. Above 1 it is a work in volumes. */
  volumes: number;
}

export interface Availability {
  configured: boolean;
  fetchedAt?: string;
  /** Titles the register names that no volume here answers to. */
  unmatched?: string[];
  /** Keyed by `normaliseTitle` and, for a work in volumes, by `workKey`. */
  holdings: Record<string, Holding>;
}

/**
 * What is on the shelf this afternoon.
 *
 * NEVER THROWS. Availability is an ornament on a catalogue that works without
 * it: no credential, a refused read, Google having a bad morning, the browser
 * offline — every one of those comes back as "not configured", the chips are
 * not drawn, and the archive behaves exactly as it did before there was a
 * register. A reading room does not close because a spreadsheet is down.
 */
export async function fetchAvailability(signal?: AbortSignal): Promise<Availability> {
  try {
    return await get<Availability>('/api/availability', signal);
  } catch {
    return { configured: false, holdings: {} };
  }
}

/* -- the register of consultation ---------------------------------------- */

/**
 * Enter this reader in the register, and get the count back.
 *
 * NEVER THROWS, and answers `null` for every kind of nothing: already counted
 * today, not judged a browser, no database, migration unapplied. The counter is
 * a footer ornament with a true number in it, and nothing about the archive
 * depends on it.
 *
 * `POST` with an empty body and no parameters. The Worker reads the browser's
 * own `Sec-Fetch-*` headers to tell a reader from a crawler and stores one
 * integer; nothing identifying is sent, and nothing identifying is kept.
 */
export async function enterRegister(): Promise<number | null> {
  try {
    const res = await fetch('/api/register/entry', {
      method: 'POST',
      headers: { accept: 'application/json' },
      // Same-origin by default, but said out loud: this request carries the
      // dedupe cookie and must never be sent anywhere else.
      credentials: 'same-origin',
    });
    // 204 is "not counted this time", which is the common case on a reload.
    if (res.status !== 200) return null;
    const body = (await res.json()) as { visits?: number };
    return typeof body.visits === 'number' ? body.visits : null;
  } catch {
    return null;
  }
}

/** The count on its own, for a reader who has already been entered today. */
export async function fetchRegister(): Promise<number | null> {
  try {
    const body = await get<{ configured: boolean; visits?: number }>('/api/register');
    return body.configured && typeof body.visits === 'number' ? body.visits : null;
  } catch {
    return null;
  }
}

/* -- the door ------------------------------------------------------------- */

export interface Gate {
  /** Whether a passphrase is set on this deployment at all. */
  configured: boolean;
  /** Whether this browser already holds a valid writ. */
  open: boolean;
  /** What to print when the word is refused. */
  message?: string;
}

/**
 * Whether this reader is already admitted.
 *
 * A sealed archive with no passphrase configured answers 503, which is not an
 * error to swallow: it is the difference between "say the word" and "nobody has
 * set a word, this archive cannot be opened by anybody", and the terminal
 * prints them differently.
 */
export async function gateStatus(): Promise<Gate> {
  try {
    const res = await fetch('/api/gate', {
      headers: { accept: 'application/json' },
      credentials: 'same-origin',
    });
    const body = (await res.json()) as Gate;
    return { configured: body.configured === true, open: body.open === true };
  } catch {
    // Offline, or the route is missing entirely. Treat it as "ask" rather than
    // "let them in": the middleware is the boundary and it will refuse anyway,
    // so guessing open here would only show an empty catalogue.
    return { configured: true, open: false };
  }
}

/** Offer the word. On success the browser is handed a writ and let through. */
export async function openGate(passphrase: string): Promise<Gate> {
  try {
    const res = await fetch('/api/gate', {
      method: 'POST',
      headers: { 'content-type': 'application/json', accept: 'application/json' },
      credentials: 'same-origin',
      body: JSON.stringify({ passphrase }),
    });
    const body = (await res.json()) as Gate;
    return {
      configured: body.configured === true,
      open: body.open === true,
      message: typeof body.message === 'string' ? body.message : undefined,
    };
  } catch {
    return { configured: true, open: false, message: 'THE DOOR DID NOT ANSWER.' };
  }
}
