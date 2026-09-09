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

export interface Tome extends TomeSummary {
  body: string;
  /** Call numbers this book refers to. Numbers only — never titles. */
  refers: string[];
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
