/**
 * Everything the archive remembers about a visitor lives here, and all of it
 * lives in localStorage on their own machine. Nothing is sent anywhere.
 *
 * Two preferences and nothing else. There used to be a `discoveries` list of
 * resolved call numbers, plus optional CRT scanlines and ambient music. The
 * catalogue no longer carries those heavier presentation features.
 *
 * Private-mode browsers and blocked site data throw on access rather than
 * returning null, so every read and write is wrapped. A visitor with storage
 * disabled simply rediscovers the archive each time, which is not a failure.
 */

const MUTED = 'arcanaeum.muted';
const READING_AID = 'arcanaeum.reading-aid';

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

export const muted = flag(MUTED, false);
/* The reader's plain face and open spacing. See src/screens/reader.ts. */
export const readingAid = flag(READING_AID, false);

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
