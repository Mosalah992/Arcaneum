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
 *   annotations rather than links.
 *
 * NO BODY IN THE CORPUS CONTAINS A CALL NUMBER. All 249 are Bethesda's text
 * and Bethesda does not write shelf marks, so the call-number rule below has
 * never fired on a real volume — the archive's own cross-references live in
 * the citations table and are printed as a colophon at the back of the book
 * (see `colophon()` in src/screens/reader.ts), precisely so that nothing the
 * archive added can be mistaken for something the author wrote. The rule stays
 * for the marginalia dialect, which can carry one.
 */

import { CALL_NUMBER_GLOBAL_RE } from '../../shared/shelves';

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
