/** Internal delimiters used only while SQLite builds a search snippet. */
export const SEARCH_MARK_OPEN = '\u0001';
export const SEARCH_MARK_CLOSE = '\u0002';

/** Remove every internal search delimiter before text leaves the API. */
export function stripSearchMarkers(text: string): string {
  return text
    .split(SEARCH_MARK_OPEN)
    .join('')
    .split(SEARCH_MARK_CLOSE)
    .join('');
}

/**
 * Tokenize as closely as possible to FTS5's unicode61/remove_diacritics mode.
 * Shared by the API query builder and the client-side highlighter so their
 * word and punctuation handling cannot drift apart.
 */
export function searchTokens(text: string): string[] {
  return (
    text
      .normalize('NFD')
      .replace(/\p{M}+/gu, '')
      .toLowerCase()
      .match(/[\p{L}\p{N}]+/gu) ?? []
  );
}
