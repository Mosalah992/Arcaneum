/**
 * The reader: one tome, bound.
 *
 * THE BINDING is ported from the Chronicles reader in the Centralized Archive.
 * Spread 0 is the inside of the front board facing the title page; spread s
 * after that shows pages [2s-1, 2s]; and a turn is done with a third leaf held
 * above the spread, its front carrying the outgoing page and its back the
 * incoming one, rotated on the spine. Its easing curve comes across verbatim
 * (`swing`, 0.9s) as a cubic-bézier, so this project keeps to one animation
 * library rather than taking on GSAP for one screen.
 *
 * THE PAGINATION does not come across. That reader packs discrete dated
 * entries to a character budget, which is right for a chronicle and wrong for
 * continuous prose — a budget on running text gives visibly ragged pages. Here
 * the browser breaks the text: the whole tome is laid into a fixed-height
 * two-column strip with `column-fill: auto`, which flows the remainder off to
 * the right in further columns, and each leaf is a clipped window onto a copy
 * of that strip translated to the column it should show. Every strip is one
 * spread wide, so all four lay out identically and a break falls in the same
 * place on the page, on the turning leaf, and on every clone.
 */

import { animate, cubicBezier } from 'animejs';
import { clear, el, prefersReducedMotion } from '../lib/dom';
import { fetchAvailability, fetchTome, ArchiveError, type Tome } from '../lib/api';
import { renderMarkdown } from '../lib/markdown';
import { navigate, type Screen } from '../lib/router';
import { TAILPIECE, cutout, type Box } from '../lib/rubrication';
import { heldCells, lookUp } from '../lib/holdings';
import { readingAid } from '../lib/store';
import { play, setMusicTrack } from '../lib/sound';

/** Below this the binding comes apart into one scrolling column. */
const SPREAD_MIN_WIDTH = 900;

/** A hinged board swinging. The Chronicles leaf's 0.9s. */
const TURN_MS = 900;

/**
 * The Chronicles `swing` curve, carried over as its control points.
 *
 * Built as a function, not written as a string. Anime 4.5 removed the string
 * form of `cubicBezier(...)` from the core; it does not throw, it warns and
 * quietly falls back to the default ease, so the leaf turns with the wrong
 * weight and nothing tells you but the console.
 */
const SWING = cubicBezier(0.35, 0.1, 0.28, 1);

/** Two leaves plus the spine, as a ratio. Each leaf is 23:32. */
const BOOK_RATIO = (23 * 2) / 32;

/**
 * Separation between columns inside a strip.
 *
 * Never seen — each window shows one column — but it has to be identical in
 * every strip or their breaks drift apart.
 */
const COLUMN_GAP = 64;

interface Win {
  frame: HTMLElement;
  strip: HTMLElement;
}

export function readerScreen(params: Record<string, string>): Screen {
  const id = Number(params.id);

  /* -- structure -------------------------------------------------------- */

  const head = el('div', { class: 'reader-head' });

  /*
   * The reading aid.
   *
   * A volume is set in a serif face at a manuscript measure on a textured
   * ground, which is the point of it and is also close to the worst case for a
   * dyslexic reader. This turns that off for as long as it is wanted: a plain
   * sans face, larger, with the letters, words and lines opened up, the
   * parchment grain taken out from behind the text, and the three-line red
   * initial set back into the line as an ordinary capital.
   *
   * SPACING AND FACE, NOT A SPECIAL FONT. The evidence for the dyslexia-
   * specific typefaces is genuinely mixed; the evidence for letter, word and
   * line spacing, for a shorter measure and for lower contrast is much
   * steadier, so that is what this changes. A face like OpenDyslexic or
   * Atkinson Hyperlegible can be dropped in on top of it — one @font-face and
   * one line of `--font-aid` — and ASSETS.md says so.
   *
   * Remembered, because somebody who needs it needs it on every volume.
   */
  const aid = el('button', {
    class: 'reader-aid',
    type: 'button',
    'aria-pressed': String(readingAid.get()),
    title: 'Plain face, wider spacing, no texture behind the text',
  });
  aid.textContent = 'READING AID';
  aid.addEventListener('click', () => {
    const next = aid.getAttribute('aria-pressed') !== 'true';
    aid.setAttribute('aria-pressed', String(next));
    readingAid.set(next);
    applyAid();
    // The face and the spacing both change, so the text breaks somewhere else
    // and every column has to be measured again.
    measure();
  });

  function applyAid(): void {
    element.classList.toggle('reader--aid', readingAid.get());
  }

  const makeWin = (frameClass: string): Win => {
    const strip = el('article', { class: 'leaves' });
    return { frame: el('div', { class: frameClass }, strip), strip };
  };

  const left = makeWin('page__win');
  const right = makeWin('page__win');
  const front = makeWin('turnleaf__win');
  const back = makeWin('turnleaf__win');
  const wins = [left, right, front, back];

  const board = el(
    'div',
    { class: 'board', 'aria-hidden': 'true' },
    el('div', { class: 'board__sigil' }),
  );

  const shade = el('div', { class: 'turnleaf__shade', 'aria-hidden': 'true' });
  const turnleaf = el(
    'div',
    { class: 'turnleaf', 'aria-hidden': 'true' },
    el('div', { class: 'turnleaf__face turnleaf__face--front' }, front.frame),
    el('div', { class: 'turnleaf__face turnleaf__face--back' }, back.frame),
    shade,
  );

  const book = el(
    'div',
    { class: 'book' },
    el('div', { class: 'page page--left' }, board, left.frame),
    el('div', { class: 'spine', 'aria-hidden': 'true' }),
    el('div', { class: 'page page--right' }, right.frame),
    turnleaf,
  );

  const stage = el('div', { class: 'book-stage' }, book);

  const prev = el('button', { class: 'pager', type: 'button', onclick: () => turn(-1) });
  prev.textContent = '< BACK';
  const next = el('button', { class: 'pager', type: 'button', onclick: () => turn(1) });
  next.textContent = 'FORWARD >';

  const folio = el('div', { class: 'folio' });
  const foot = el('div', { class: 'reader-foot' }, prev, folio, next);

  const element = el('div', { class: 'screen reader' }, head, stage, foot);
  applyAid();

  /* -- state ------------------------------------------------------------ */

  let tome: Tome | null = null;
  let register: Awaited<ReturnType<typeof fetchAvailability>> | null = null;
  let cited: string[] = [];
  /** Columns in the strip. Column 0 is the title page. */
  let pages = 1;
  let spread = 0;
  /** One column plus its gap: how far a strip travels per page. */
  let stride = 1;
  let land: (() => void) | null = null;

  const paged = (): boolean => window.innerWidth > SPREAD_MIN_WIDTH;
  const maxSpread = (): number => Math.max(0, Math.ceil((pages - 1) / 2));

  /** Spread 0 faces the board; every later one is an odd page and the next. */
  const facing = (s: number): [number, number] =>
    s === 0 ? [-1, 0] : [2 * s - 1, 2 * s];

  /* -- layout ----------------------------------------------------------- */

  /**
   * Size the book to the stage, then lay every strip out one spread wide.
   *
   * Called on load, on resize, and once the fonts have arrived — a fallback
   * face breaks the text in different places, so measuring before the real
   * face lands would page the tome wrongly and never correct itself.
   */
  function measure(): void {
    if (!paged()) {
      book.classList.remove('book--cover', 'book--turning');
      book.style.width = '';
      book.style.height = '';
      for (const win of wins) {
        win.strip.style.width = '';
        win.strip.style.columnWidth = '';
        win.strip.style.transform = '';
        win.frame.style.visibility = '';
      }
      pages = 1;
      spread = 0;
      updateFoot();
      return;
    }

    const availableWidth = stage.clientWidth;
    const availableHeight = stage.clientHeight;
    if (availableWidth === 0 || availableHeight === 0) return;

    const width = Math.min(availableWidth, availableHeight * BOOK_RATIO);
    book.style.width = `${Math.floor(width)}px`;
    book.style.height = `${Math.floor(width / BOOK_RATIO)}px`;

    const columnWidth = left.frame.clientWidth;
    if (columnWidth === 0) return;

    for (const win of wins) {
      win.strip.style.width = `${columnWidth * 2 + COLUMN_GAP}px`;
      win.strip.style.columnWidth = `${columnWidth}px`;
      win.strip.style.columnGap = `${COLUMN_GAP}px`;
    }

    stride = columnWidth + COLUMN_GAP;
    pages = Math.max(1, Math.round((left.strip.scrollWidth + COLUMN_GAP) / stride));

    spread = Math.min(spread, maxSpread());
    show(spread);
  }

  /** Point one window at one column. A column past the end shows nothing. */
  function put(win: Win, index: number): void {
    win.frame.style.visibility = index < 0 || index >= pages ? 'hidden' : '';
    win.strip.style.transform = `translateX(${-index * stride}px)`;
  }

  function show(s: number): void {
    const [l, r] = facing(s);
    book.classList.toggle('book--cover', s === 0);
    put(left, l);
    put(right, r);
    updateFoot();
  }

  function updateFoot(): void {
    prev.disabled = !paged() || spread === 0;
    next.disabled = !paged() || spread >= maxSpread();

    const parts: string[] = [];
    if (paged()) {
      parts.push(spread === 0 ? 'TITLE PAGE' : `SPREAD ${spread} OF ${maxSpread()}`);
    } else if (tome !== null) {
      parts.push(tome.school.toUpperCase());
    }
    if (cited.length > 0) {
      parts.push(`REFERS TO ${cited.length} OTHER VOLUME${cited.length === 1 ? '' : 'S'}`);
    }
    // Said out loud, the way the catalogue says UP/DOWN SELECT ENTER OPEN. The
    // arrows have always turned the leaf; nothing on the screen admitted it,
    // so the two buttons read as the only way through a book.
    if (paged()) parts.push('← → TURN');
    folio.textContent = parts.join('  ·  ');
  }

  /* -- turning ---------------------------------------------------------- */

  /**
   * Turn a leaf.
   *
   * The spread is committed by `finish()`, which is idempotent and always
   * writes the FINAL state, so it does not matter which of the three things
   * that can call it gets there first: the tween completing, the tab going
   * hidden, or the backstop timer. That redundancy is deliberate. A turn whose
   * landing hangs off the frame loop alone strands the reader on a half-turned
   * leaf with the controls locked the moment the tab stops painting — this
   * codebase shipped exactly that bug in its first reader, and the Chronicles
   * reader carries its own guard against the same thing.
   */
  function turn(direction: number): void {
    if (!paged() || land !== null) return;

    const to = spread + direction;
    if (to < 0 || to > maxSpread()) return;

    // Which physical leaf moves: forward it is the current right-hand page,
    // back it is the right-hand page of the spread being returned to. Its back
    // face is always the page after its front.
    const faceIndex = direction > 0 ? facing(spread)[1] : facing(to)[1];
    put(front, faceIndex);
    put(back, faceIndex + 1);

    // The half of the spread the leaf covers at rest can be swapped now,
    // hidden underneath it, so nothing changes in view mid-turn.
    if (direction > 0) put(right, facing(to)[1]);
    else put(left, facing(to)[0]);

    play('page');

    if (prefersReducedMotion()) {
      spread = to;
      show(to);
      return;
    }

    const from = direction > 0 ? 0 : -180;
    const until = direction > 0 ? -180 : 0;

    turnleaf.style.transform = `rotateY(${from}deg)`;
    book.classList.add('book--turning');
    // The board must stay showing while the title leaf lifts off it.
    book.classList.toggle('book--cover', Math.min(spread, to) === 0);

    let landed = false;
    const finish = (): void => {
      if (landed) return;
      landed = true;
      window.clearTimeout(timer);
      document.removeEventListener('visibilitychange', onHidden);
      land = null;
      book.classList.remove('book--turning');
      turnleaf.style.transform = '';
      shade.style.opacity = '0';
      spread = to;
      show(to);
    };

    const onHidden = (): void => {
      if (document.visibilityState === 'hidden') finish();
    };

    const timer = window.setTimeout(finish, TURN_MS + 250);
    document.addEventListener('visibilitychange', onHidden);
    land = finish;

    animate(turnleaf, {
      rotateY: [from, until],
      duration: TURN_MS,
      ease: SWING,
      onComplete: finish,
    });

    // Brightest at the half-turn, gone by the time the page is down.
    animate(shade, {
      opacity: [0, 0.55, 0],
      duration: TURN_MS,
      ease: SWING,
    });
  }

  function goTo(target: number): void {
    if (!paged() || land !== null) return;
    const to = Math.min(Math.max(target, 0), maxSpread());
    if (to === spread) return;
    // One leaf swinging over cannot honestly stand for six of them, so a jump
    // across the volume is not animated at all. The Chronicles reader draws the
    // same line and it is right.
    if (Math.abs(to - spread) === 1) {
      turn(to > spread ? 1 : -1);
      return;
    }
    spread = to;
    show(to);
  }

  /* -- input ------------------------------------------------------------ */

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
        goTo(0);
        break;
      case 'End':
        event.preventDefault();
        goTo(maxSpread());
        break;
      case 'Escape':
      case 'Backspace':
        event.preventDefault();
        navigate('/catalogue');
        break;
    }
  }

  const onResize = (): void => {
    land?.();
    measure();
  };

  /** One listener for every colophon reference on every clone of the strip. */
  function onColophonClick(event: MouseEvent): void {
    const target = event.target;
    if (!(target instanceof Element)) return;
    const ref = target.closest<HTMLElement>('.colophon__ref');
    const id = ref?.dataset.tome;
    if (id === undefined) return;
    play('tick');
    navigate(`/tome/${id}`);
  }

  element.addEventListener('click', onColophonClick);
  window.addEventListener('keydown', onKeydown);
  window.addEventListener('resize', onResize);

  // The volumes have their own voice.
  setMusicTrack('reading');

  /* -- loading ---------------------------------------------------------- */

  function fail(message: string): void {
    clear(head);
    book.classList.remove('book--cover');
    left.strip.replaceChildren(
      el('div', { class: 'reader-status reader-status--error' }, message),
    );
    right.frame.style.visibility = 'hidden';
    folio.textContent = '';
    prev.disabled = true;
    next.disabled = true;
  }

  const escapeHtml = (text: string): string =>
    text.replace(/[&<>"]/g, (c) => `&#${c.charCodeAt(0)};`);

  /*
   * An ornament is written out at the right size but with no image, and the
   * cut-out is dropped in once the sheet has been labelled. The size comes
   * from the recorded box, so the leaf paginates identically whether or not
   * the illumination has arrived yet — the text does not reflow underneath it.
   */
  const ornament = (name: string, box: Box, height: number, extra = ''): string =>
    `<div class="ornament ${extra}" data-piece="${name}" aria-hidden="true"` +
    ` style="width:${((box.w / box.h) * height).toFixed(3)}em;height:${height}em"></div>`;

  const pieces = new Map<string, Box>();

  function dressOrnaments(strip: HTMLElement): void {
    for (const node of strip.querySelectorAll<HTMLElement>('.ornament[data-piece]')) {
      const name = node.dataset.piece!;
      const box = pieces.get(name);
      if (box === undefined) continue;
      void cutout(name, box).then((art) => {
        if (art === null) {
          node.remove();
          return;
        }
        node.style.backgroundImage = `url(${art.url})`;
        node.style.width = `${(art.aspect * parseFloat(node.style.height)).toFixed(3)}em`;
      });
    }
  }

  /*
   * The colophon: what else the archive holds on this.
   *
   * SET APART FROM THE PAGE, after the tailpiece, in the interface's own
   * bitmap face rather than the book's — because it is NOT part of the book.
   * Bethesda's text is never edited, and these references are the archive's
   * apparatus: a handful derived from one volume naming another, the rest
   * curated in content/cross-references.json because Bethesda's books almost
   * never cite each other. The last line of it says so, in the reader's own
   * view rather than only in PROVENANCE.md.
   *
   * Written as markup and delegated for clicks, because the whole strip is
   * `innerHTML`'d into four windows — the two leaves and the two faces of the
   * turning leaf — and four sets of listeners on four clones of the same
   * buttons is four times the work and one more thing to tear down.
   */
  function colophon(volume: Tome): string {
    if (volume.refers.length === 0) return '';

    const entries = volume.refers
      .map(
        (ref) =>
          `<li><button class="colophon__ref" type="button" data-tome="${ref.id}">` +
          `<span class="colophon__call">${escapeHtml(ref.call_number)}</span>` +
          `<span class="colophon__ttl">${escapeHtml(ref.title)}</span>` +
          (ref.restricted ? '<span class="colophon__seal">SEALED</span>' : '') +
          '</button></li>',
      )
      .join('');

    return (
      '<footer class="colophon">' +
      '<p class="colophon__head">ELSEWHERE IN THE ARCHIVE</p>' +
      `<ul class="colophon__list">${entries}</ul>` +
      '<p class="colophon__note">The archive’s own references. ' +
      'No word of the volume above has been altered.</p>' +
      '</footer>'
    );
  }

  /** Column 0, by itself: the leaf the board faces when the volume opens. */
  function titlePage(volume: Tome): string {
    pieces.set('tailpiece', TAILPIECE);

    return [
      '<header class="title-page">',
      // The College's own sigil, the same on all 249 volumes. It is blocked
      // into the board on a wide screen — see `.board__sigil` — and this is
      // the same mark for the narrow layout, where the binding comes apart and
      // there is no board to carry it. Not an ornament cut from the painted
      // sheet: it is a supplied plate with a known aspect ratio, so it is
      // written out at its final size and the leaf paginates correctly on the
      // first pass, with nothing that reflows the text when the image lands.
      '<div class="title-page__sigil" aria-hidden="true"></div>',
      `<p class="title-page__call">${escapeHtml(volume.call_number)}</p>`,
      `<h1 class="title-page__title">${escapeHtml(volume.title)}</h1>`,
      '<div class="title-page__rule"></div>',
      `<p class="title-page__author">${escapeHtml(volume.author)}</p>`,
      `<p class="title-page__school">${escapeHtml(volume.school)}</p>`,
      volume.restricted ? '<p class="title-page__seal">SEALED RECORD</p>' : '',
      '</header>',
    ].join('');
  }

  /** Case, punctuation and spacing removed, for comparing two lines of type. */
  const normalise = (text: string): string =>
    text
      .toLowerCase()
      .replace(/[‘’“”]/g, "'")
      .replace(/[^a-z0-9']+/g, ' ')
      .trim();

  const words = (text: string): number => (text.trim().match(/\S+/g) ?? []).length;

  /**
   * The words before the words: how many of these volumes open.
   *
   * Bethesda's books carry their own front matter — the title again, then
   * `by`, then the author on a line of its own — and the port keeps it,
   * because the rule of this archive is that the text is never edited. It is
   * still front matter and not prose, so it is marked as such: it must not be
   * set as running text, and it must not be given the red initial. The reader
   * shipped with exactly that bug and it was visible on the first page of the
   * first volume you opened — a burgundy capital B three lines tall with a
   * lower-case y hanging off it, because `by` is a paragraph.
   *
   * Returns the index of the first block that is not front matter.
   */
  function markFrontMatter(strip: HTMLElement, volume: Tome): number {
    const blocks = [...strip.children].filter((node) => node.tagName !== 'HEADER');
    const title = normalise(volume.title);
    const author = normalise(volume.author);

    let index = 0;
    for (; index < blocks.length && index < 5; index++) {
      const block = blocks[index]!;
      if (block.tagName !== 'P') break;
      const text = normalise(block.textContent ?? '');
      if (text === '') break;

      if (text === title) block.className = 'frontmatter frontmatter--title';
      else if (text === 'by') block.className = 'frontmatter frontmatter--by';
      // `startsWith`, not equality: the catalogue's author is often fuller than
      // the book's own byline — "Zurin Arctus et al." against "Zurin Arctus".
      else if (author.startsWith(text) || text.startsWith(`by ${author}`)) {
        block.className = 'frontmatter frontmatter--author';
      } else break;
    }
    return index;
  }

  /**
   * Rubricate the opening.
   *
   * The first letter of the first paragraph of prose is lifted out and set as
   * a red initial — which is what rubrication is, and what the burgundy
   * headings elsewhere in the leaf are doing too.
   *
   * IT IS THE FIRST PARAGRAPH AFTER THE FRONT MATTER AND ANY HEADING THAT
   * INTRODUCES IT, and only if that paragraph is actually prose: eight words
   * or more, opening on a letter. Everything else
   * gets no initial at all, which is the right answer and not a shortfall.
   * A numbered treatise, a book of verse, a page of shopping-list notes — a
   * three-line capital dropped into any of those lands on a chapter number or
   * an orphaned particle and looks like a mistake, because it is one. A volume
   * with no initial simply looks like a volume that was not illuminated, which
   * is what most of them were.
   */
  function rubricate(strip: HTMLElement, from: number): void {
    const blocks = [...strip.children].filter((node) => node.tagName !== 'HEADER');

    // Past whatever announces the prose. A third of these books open on a
    // heading — `Volume One`, `Part I`, `Chapter 1` — and the initial belongs
    // on the paragraph under it, not nowhere. Headings and rules only: a
    // paragraph is prose and stops the search, whatever it says.
    let index = from;
    for (let skipped = 0; skipped < 3; skipped++) {
      const block = blocks[index];
      if (block === undefined) return;
      if (block.tagName !== 'H2' && block.tagName !== 'HR') break;
      index++;
    }

    const opening = blocks[index];
    if (opening === undefined || opening.tagName !== 'P') return;

    const text = opening.firstChild;
    if (text === null || text.nodeType !== Node.TEXT_NODE) return;

    const body = text.textContent ?? '';
    if (words(body) < 8) return;

    const letter = body.trimStart().charAt(0);
    if (!/\p{L}/u.test(letter)) return;

    const rest = body.slice(body.indexOf(letter) + 1);
    const initial = document.createElement('span');
    initial.className = 'rubric-initial';
    initial.textContent = letter;
    opening.replaceChild(document.createTextNode(rest), text);
    opening.prepend(initial);
    opening.classList.add('has-initial');
  }

  /*
   * The running head, redrawn when the register lands.
   *
   * The same two cells the catalogue shows, so a librarian who has walked from
   * the list into the book does not have to walk back to find out whether
   * there is a copy on the shelf.
   */
  function drawHead(): void {
    if (tome === null) return;
    const shelved = lookUp(tome.title, register);
    head.replaceChildren(
      ...[
        el('span', { class: 'call' }, tome.call_number),
        el('span', { class: 'ttl' }, tome.title),
        tome.restricted ? el('span', { class: 'sealed' }, 'SEALED') : null,
        el('span', { class: 'by' }, tome.author.toUpperCase()),
        shelved.state === 'unlisted' ? null : el('span', { class: 'held-head' }, ...heldCells(shelved)),
        aid,
      ].filter((node): node is HTMLElement => node !== null),
    );
  }

  async function load(): Promise<void> {
    if (!Number.isSafeInteger(id) || id < 1) {
      fail('THAT IS NOT A CALL SLIP.');
      return;
    }

    left.strip.replaceChildren(
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

    drawHead();

    // The body is trusted content from our own D1, but the renderer escapes it
    // regardless so that replacing the drafts later cannot open a hole.
    const html =
      titlePage(tome) +
      renderMarkdown(tome.body) +
      ornament('tailpiece', TAILPIECE, 2.2, 'ornament--tailpiece') +
      colophon(tome);

    for (const win of wins) {
      win.strip.innerHTML = html;
      rubricate(win.strip, markFrontMatter(win.strip, tome));
      dressOrnaments(win.strip);
    }

    /*
     * The references, counted for the foot.
     *
     * `tome.refers` and NOT `citedCallNumbers(tome.body, ...)`, which is the
     * number of call numbers printed inside the prose — and that is zero for
     * all 249 of them, because the corpus is Bethesda's text and Bethesda does
     * not write call numbers. The line had never once appeared.
     */
    cited = tome.refers.map((ref) => ref.call_number);
    spread = 0;

    // A fallback face breaks the text elsewhere, so measure again once the
    // real one has landed.
    void document.fonts?.ready.then(measure);
    requestAnimationFrame(measure);
  }

  // Never awaited. The head draws without it and redraws if it arrives.
  void fetchAvailability().then((answer) => {
    register = answer;
    drawHead();
  });

  void load();

  return {
    element,
    title: 'READING ROOM',
    destroy() {
      land?.();
      setMusicTrack('archive');
      window.removeEventListener('keydown', onKeydown);
      window.removeEventListener('resize', onResize);
    },
  };
}
