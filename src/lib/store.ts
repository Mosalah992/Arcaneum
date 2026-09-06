/**
 * Everything the archive remembers about a visitor lives here, and all of it
 * lives in localStorage on their own machine. Nothing is sent anywhere.
 *
 * Private-mode browsers and blocked site data throw on access rather than
 * returning null, so every read and write is wrapped. A visitor with storage
 * disabled simply rediscovers the archive each time, which is not a failure.
 */

const DISCOVERIES = 'arcanaeum.discoveries';
const SCANLINES = 'arcanaeum.scanlines';
const MUTED = 'arcanaeum.muted';
const VISITED = 'arcanaeum.visited';

function read(key: string): string | null {
  try {
    return localStorage.getItem(key);
  } catch {
    return null;
  }
}

function write(key: string, value: string): void {
  try {
    localStorage.setItem(key, value);
  } catch {
    /* storage unavailable; the session simply will not be remembered */
  }
}

function drop(key: string): void {
  try {
    localStorage.removeItem(key);
  } catch {
    /* as above */
  }
}

/** Call numbers the visitor has resolved. One key, as specified. */
export function discoveries(): string[] {
  const raw = read(DISCOVERIES);
  if (raw === null) return [];
  try {
    const parsed: unknown = JSON.parse(raw);
    if (!Array.isArray(parsed)) return [];
    return parsed.filter((v): v is string => typeof v === 'string');
  } catch {
    return [];
  }
}

export function remember(callNumber: string): void {
  const found = discoveries();
  if (found.includes(callNumber)) return;
  found.push(callNumber);
  write(DISCOVERIES, JSON.stringify(found));
}

export function forgetDiscoveries(): void {
  drop(DISCOVERIES);
}

export const scanlines = flag(SCANLINES, false);
export const muted = flag(MUTED, false);
export const visited = flag(VISITED, false);

function flag(key: string, fallback: boolean) {
  return {
    get(): boolean {
      const raw = read(key);
      return raw === null ? fallback : raw === '1';
    },
    set(value: boolean): void {
      write(key, value ? '1' : '0');
    },
  };
}
