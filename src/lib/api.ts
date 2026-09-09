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

async function get<T>(path: string): Promise<T> {
  let res: Response;
  try {
    res = await fetch(path, { headers: { accept: 'application/json' } });
  } catch {
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

export function resolveCallNumber(callNumber: string): Promise<Resolved> {
  return get<Resolved>(`/api/resolve/${encodeURIComponent(callNumber)}`);
}
