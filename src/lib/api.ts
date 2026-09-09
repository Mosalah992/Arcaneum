/** Typed wrappers over the three read-only routes. */

export interface TomeSummary {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
}

export interface Tome extends TomeSummary {
  body: string;
  restricted: boolean;
}

export interface Resolved extends TomeSummary {
  restricted: boolean;
}

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
