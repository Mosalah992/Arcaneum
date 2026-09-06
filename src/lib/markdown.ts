/**
 * A renderer for exactly the markdown the tomes use, and one dialect feature
 * they need that no library provides: marginalia.
 *
 * Block grammar
 *   ## text        heading
 *   :: text        marginalia — a librarian's pencil note, set into the margin
 *   ---            rule
 *   > text         quotation
 *   anything else  paragraph
 *
 * Inline grammar
 *   **bold**  *italic*  and bare call numbers, which are marked up as
 *   annotations rather than links. Making them clickable would give the
 *   discovery away; the reader has to notice one and type it into the
 *   catalogue themselves.
 */

import { CALL_NUMBER_GLOBAL_RE } from '../../shared/schools';

const ESCAPES: Record<string, string> = {
  '&': '&amp;',
  '<': '&lt;',
  '>': '&gt;',
  '"': '&quot;',
};

function escapeHtml(text: string): string {
  return text.replace(/[&<>"]/g, (c) => ESCAPES[c]!);
}

function inline(text: string): string {
  let html = escapeHtml(text);
  html = html.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
  html = html.replace(/(^|[^*])\*([^*\n]+)\*/g, '$1<em>$2</em>');
  html = html.replace(
    CALL_NUMBER_GLOBAL_RE,
    (cn) => `<span class="call-ref" data-call-number="${cn}">${cn}</span>`,
  );
  return html;
}

/** Returns an HTML string of block elements. */
export function renderMarkdown(source: string): string {
  const out: string[] = [];
  let paragraph: string[] = [];

  const flush = (): void => {
    if (paragraph.length === 0) return;
    out.push(`<p>${inline(paragraph.join(' '))}</p>`);
    paragraph = [];
  };

  for (const raw of source.replace(/\r\n/g, '\n').split('\n')) {
    const line = raw.trim();

    if (line === '') {
      flush();
    } else if (/^-{3,}$/.test(line)) {
      flush();
      out.push('<hr />');
    } else if (line.startsWith('## ')) {
      flush();
      out.push(`<h2>${inline(line.slice(3))}</h2>`);
    } else if (line.startsWith('# ')) {
      flush();
      out.push(`<h2>${inline(line.slice(2))}</h2>`);
    } else if (line.startsWith(':: ')) {
      flush();
      out.push(`<aside class="marginalia">${inline(line.slice(3))}</aside>`);
    } else if (line.startsWith('> ')) {
      flush();
      out.push(`<blockquote>${inline(line.slice(2))}</blockquote>`);
    } else {
      paragraph.push(line);
    }
  }
  flush();

  return out.join('\n');
}

/** Every distinct call number a body refers to, in order of appearance. */
export function citedCallNumbers(source: string, self: string): string[] {
  const found = source.match(CALL_NUMBER_GLOBAL_RE) ?? [];
  return [...new Set(found)].filter((cn) => cn !== self);
}
