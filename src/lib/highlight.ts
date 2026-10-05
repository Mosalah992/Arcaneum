import { searchTokens, stripSearchMarkers } from '../../shared/search';

export interface HighlightPart {
  text: string;
  highlighted: boolean;
}

/** Escape a literal before placing it in a regular expression. */
export function escapeRegExp(text: string): string {
  return text.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

/**
 * Build the literal match pattern used by the catalogue and FTS query.
 * Earlier words are exact tokens; the final word is a token prefix so results
 * can update while the reader is still typing it.
 */
function highlightPattern(query: string): RegExp | null {
  const tokens = searchTokens(query);
  if (tokens.length === 0) return null;

  const exact = new Set(tokens.slice(0, -1));
  const terms = [...new Set(tokens)].sort((a, b) => b.length - a.length);
  const word = '\\p{L}\\p{M}\\p{N}';
  const alternatives = terms.map((term) => {
    const literal = escapeRegExp(term);
    return exact.has(term) ? `${literal}(?![${word}])` : literal;
  });

  return new RegExp(`(^|[^${word}])(${alternatives.join('|')})`, 'giu');
}

/** Split plain text into safe text-node and highlighted runs. */
export function highlightParts(text: string, query: string): HighlightPart[] {
  const plain = stripSearchMarkers(text);
  const pattern = highlightPattern(query);
  if (pattern === null) return [{ text: plain, highlighted: false }];

  const parts: HighlightPart[] = [];
  let cursor = 0;

  for (const match of plain.matchAll(pattern)) {
    const prefix = match[1] ?? '';
    const hit = match[2] ?? '';
    const hitStart = (match.index ?? 0) + prefix.length;

    if (hitStart > cursor) {
      parts.push({ text: plain.slice(cursor, hitStart), highlighted: false });
    }
    if (hit !== '') {
      parts.push({ text: hit, highlighted: true });
    }

    cursor = hitStart + hit.length;
  }

  if (cursor < plain.length) {
    parts.push({ text: plain.slice(cursor), highlighted: false });
  }

  return parts.length === 0 ? [{ text: plain, highlighted: false }] : parts;
}

/** Render highlighted text without interpreting any corpus text as HTML. */
export function highlightedText(text: string, query: string): DocumentFragment {
  const fragment = document.createDocumentFragment();

  for (const part of highlightParts(text, query)) {
    if (!part.highlighted) {
      fragment.append(document.createTextNode(part.text));
      continue;
    }

    const mark = document.createElement('mark');
    mark.className = 'search-hit';
    mark.append(document.createTextNode(part.text));
    fragment.append(mark);
  }

  return fragment;
}
