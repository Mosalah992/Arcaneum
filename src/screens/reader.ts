/**
 * The reader: one tome across a two-page parchment spread.
 *
 * Pagination is done by the browser rather than by measuring code. The prose
 * is laid into a fixed-height, two-column box with `column-fill: auto`, which
 * makes the rest of the tome flow off to the right in further column pairs.
 * Turning a spread is a translate. Resizing re-paginates for free.
 */

import { animate } from 'animejs';
import { clear, el, prefersReducedMotion } from '../lib/dom';
import { fetchTome, ArchiveError, type Tome } from '../lib/api';
import { renderMarkdown, citedCallNumbers } from '../lib/markdown';
import { navigate, type Screen } from '../lib/router';

/** Below this the spread is replaced by a single scrolling column. */
const SPREAD_MIN_WIDTH = 900;

/** Length of the leaf sweep, and the floor between turns. */
const TURN_MS = 280;

export function readerScreen(params: Record<string, string>): Screen {
  const id = Number(params.id);

  const head = el('div', { class: 'reader-head' });
  const leaves = el('article', { class: 'leaves' });
  const clip = el('div', { class: 'spread-clip' }, leaves);
  const flip = el('div', { class: 'page-flip', 'aria-hidden': 'true' });
  const spread = el('div', { class: 'spread' }, clip, flip);

  const prev = el('button', {
    class: 'pager',
    type: 'button',
    onclick: () => turn(-1),
  });
  prev.textContent = '< BACK';

  const next = el('button', {
    class: 'pager',
    type: 'button',
    onclick: () => turn(1),
  });
  next.textContent = 'FORWARD >';

  const folio = el('div', { class: 'folio' });
  const foot = el('div', { class: 'reader-foot' }, prev, folio, next);

  const element = el('div', { class: 'screen reader' }, head, spread, foot);

  let tome: Tome | null = null;
  let cited: string[] = [];
  let spreads = 1;
  let at = 0;
  let lastTurn = 0;

  function paged(): boolean {
    return window.innerWidth > SPREAD_MIN_WIDTH;
  }

  /** Column width plus gutter, doubled, is one spread's worth of travel. */
  function stride(): number {
    const gap = parseFloat(getComputedStyle(leaves).columnGap) || 0;
    return clip.clientWidth + gap;
  }

  function measure(): void {
    if (!paged()) {
      spreads = 1;
      at = 0;
      leaves.style.transform = '';
      updateFoot();
      return;
    }
    const gap = parseFloat(getComputedStyle(leaves).columnGap) || 0;
    const column = (clip.clientWidth - gap) / 2;
    const columns = Math.max(
      1,
      Math.round((leaves.scrollWidth + gap) / (column + gap)),
    );
    spreads = Math.max(1, Math.ceil(columns / 2));
    at = Math.min(at, spreads - 1);
    leaves.style.transform = `translateX(${-at * stride()}px)`;
    updateFoot();
  }

  function updateFoot(): void {
    prev.disabled = at === 0;
    next.disabled = at >= spreads - 1;

    const parts = [
      paged()
        ? `SPREAD ${at + 1} OF ${spreads}`
        : (tome?.school.toUpperCase() ?? ''),
    ];
    if (cited.length > 0) {
      parts.push(
        `REFERS TO ${cited.length} OTHER VOLUME${cited.length === 1 ? '' : 'S'}`,
      );
    }
    folio.textContent = parts.filter((part) => part !== '').join('  ·  ');
  }

  /**
   * The spread changes first and the leaf sweeps afterward.
   *
   * Nothing about which spread is showing depends on the animation finishing.
   * Driving the page change from an animation callback latches the reader shut
   * whenever the frame loop stalls — a backgrounded tab is enough — and the
   * visitor comes back to a book that will not turn. The sweep is decoration
   * and is treated as decoration.
   */
  function goTo(target: number, direction: number): void {
    if (!paged()) return;

    const now = performance.now();
    if (now - lastTurn < TURN_MS) return;
    if (target < 0 || target >= spreads || target === at) return;

    lastTurn = now;
    at = target;
    leaves.style.transform = `translateX(${-at * stride()}px)`;
    updateFoot();

    if (prefersReducedMotion()) return;

    // Forward, the leaf retreats to the left and uncovers the new spread.
    flip.style.transformOrigin = direction > 0 ? 'left center' : 'right center';
    animate(flip, {
      opacity: [0.92, 0],
      scaleX: [1, 0.04],
      duration: TURN_MS,
      ease: 'outQuad',
    });
  }

  function turn(delta: number): void {
    goTo(at + delta, delta);
  }

  function onKeydown(event: KeyboardEvent): void {
    if (event.metaKey || event.ctrlKey || event.altKey) return;
    switch (event.key) {
      case 'ArrowRight':
      case 'PageDown':
      case ' ':
        event.preventDefault();
        turn(1);
        break;
      case 'ArrowLeft':
      case 'PageUp':
        event.preventDefault();
        turn(-1);
        break;
      case 'Home':
        event.preventDefault();
        goTo(0, -1);
        break;
      case 'End':
        event.preventDefault();
        goTo(spreads - 1, 1);
        break;
      case 'Escape':
      case 'Backspace':
        event.preventDefault();
        navigate('/catalogue');
        break;
    }
  }

  const onResize = (): void => measure();

  window.addEventListener('keydown', onKeydown);
  window.addEventListener('resize', onResize);

  function fail(message: string): void {
    clear(head);
    leaves.replaceChildren(
      el('div', { class: 'reader-status reader-status--error' }, message),
    );
    folio.textContent = '';
    prev.disabled = true;
    next.disabled = true;
  }

  async function load(): Promise<void> {
    if (!Number.isSafeInteger(id) || id < 1) {
      fail('THAT IS NOT A CALL SLIP.');
      return;
    }

    leaves.replaceChildren(
      el('div', { class: 'reader-status' }, 'FETCHING THE VOLUME...'),
    );

    try {
      tome = await fetchTome(id);
    } catch (err) {
      fail(
        err instanceof ArchiveError && err.status === 404
          ? 'NO SUCH VOLUME IS HELD.'
          : err instanceof ArchiveError
            ? err.message.toUpperCase()
            : 'THE ARCHIVE DID NOT ANSWER.',
      );
      return;
    }

    head.replaceChildren(
      ...[
        el('span', { class: 'call' }, tome.call_number),
        el('span', { class: 'ttl' }, tome.title),
        tome.restricted ? el('span', { class: 'sealed' }, 'SEALED') : null,
        el('span', { class: 'by' }, tome.author.toUpperCase()),
      ].filter((node): node is HTMLSpanElement => node !== null),
    );

    // The body is trusted content from our own D1, but the renderer escapes it
    // regardless so that replacing the drafts later cannot open a hole.
    leaves.innerHTML = renderMarkdown(tome.body);
    cited = citedCallNumbers(tome.body, tome.call_number);
    at = 0;

    // Fonts change the column count, so wait for them before measuring.
    void document.fonts?.ready.then(measure);
    requestAnimationFrame(measure);
  }

  void load();

  return {
    element,
    title: 'READING ROOM',
    destroy() {
      window.removeEventListener('keydown', onKeydown);
      window.removeEventListener('resize', onResize);
    },
  };
}
