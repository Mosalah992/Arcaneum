/**
 * The catalogue: a pixel-bitmap terminal over the open shelf.
 *
 * The search field does two jobs. Typed prose filters the visible list. A
 * typed call number is a request slip: pressing Enter sends it to
 * /api/resolve, and if the roll lists that number the volume opens, whether or
 * not it was ever on the shelf.
 */

import { SHELVES, CALL_NUMBER_RE } from '../../shared/shelves';
import { clear, el } from '../lib/dom';
import {
  listTomes,
  resolveCallNumber,
  searchTomes,
  ArchiveError,
  type TomeSummary,
} from '../lib/api';
import { discoveries, remember } from '../lib/store';
import { navigate, type Screen } from '../lib/router';
import { play } from '../lib/sound';

interface Row extends TomeSummary {
  sealed: boolean;
  /** Present only on rows that came back from a body search. */
  excerpt?: string;
}

/** How long to wait after the last keystroke before asking the archive. */
const SEARCH_DEBOUNCE = 180;
/** Shorter than this is not a search worth a round trip. */
const SEARCH_MIN = 2;

/** The control characters /api/search brackets a matched run with. */
const MARK_OPEN = '';
const MARK_CLOSE = '';

export function catalogueScreen(): Screen {
  let school: string | null = null;
  let query = '';
  let shelf: Row[] = [];
  let rows: Row[] = [];
  let selected = 0;

  /*
   * Two kinds of result share one list.
   *
   * `found` null means the visitor is filtering the shelf they already have —
   * instant, local, and only over what a listing carries. Non-null means the
   * archive has searched the prose. Both render into the same `rows`, in the
   * same order as the buttons, so the keyboard model does not have to know
   * which one it is looking at.
   */
  let found: Row[] | null = null;
  let foundTotal = 0;
  let truncated = false;
  let debounce = 0;
  let inFlight: AbortController | null = null;

  const input = el('input', {
    class: 'search-input',
    type: 'text',
    autocomplete: 'off',
    autocapitalize: 'characters',
    spellcheck: 'false',
    'aria-label': 'Search the catalogue, or enter a call number',
    placeholder: 'search, or enter a call number',
  });

  const mirrorText = el('span');
  const cursor = el('span', { class: 'block-cursor' });
  const mirror = el(
    'span',
    { class: 'search-mirror', 'aria-hidden': 'true' },
    mirrorText,
    cursor,
  );

  const hint = el('span', { class: 'search-hint' }, 'UP/DOWN SELECT   ENTER OPEN');
  const status = el('div', { class: 'results-status' }, 'CONSULTING THE ROLL...');
  const list = el('ol', {
    class: 'results',
    role: 'listbox',
    'aria-label': 'Catalogue results',
  });

  const tablets = el(
    'nav',
    { class: 'tablets' },
    el('p', { class: 'tablets-legend' }, 'SHELVES'),
  );
  const tabletButtons = new Map<string | null, HTMLButtonElement>();

  for (const name of [null, ...SHELVES]) {
    const button = el(
      'button',
      {
        class: 'tablet',
        type: 'button',
        'aria-pressed': String(school === name),
        onclick: () => selectShelf(name),
      },
      name === null ? 'ALL SHELVES' : name.toUpperCase(),
    );
    tabletButtons.set(name, button);
    tablets.append(button);
  }

  const element = el(
    'div',
    { class: 'screen catalogue' },
    tablets,
    el(
      'div',
      { class: 'stacks' },
      el(
        'div',
        { class: 'search' },
        el('span', { class: 'search-prompt' }, '>'),
        el('div', { class: 'search-field' }, mirror, input),
        hint,
      ),
      el(
        'div',
        { class: 'results-head' },
        el('span', {}, 'NO.'),
        el('span', {}, 'CALL'),
        el('span', {}, 'TITLE'),
        el('span', {}, 'AUTHOR'),
        el('span', {}, 'SCHOOL'),
      ),
      status,
      list,
    ),
  );

  /** The block cursor is drawn, not native, so it has to be told where to sit. */
  function syncCursor(): void {
    const at = input.selectionStart ?? input.value.length;
    mirrorText.textContent = input.value.slice(0, at);
  }

  function selectShelf(name: string | null): void {
    if (school === name) return;
    school = name;
    for (const [key, button] of tabletButtons) {
      button.setAttribute('aria-pressed', String(key === name));
    }
    void load();
    if (found !== null) search();
  }

  /**
   * The shelf, plus whatever this visitor has already dug up. Discoveries are
   * resolved individually and any that fail are dropped in silence, so a stale
   * call number left in localStorage cannot break the catalogue.
   */
  async function load(): Promise<void> {
    status.className = 'results-status';
    status.textContent = 'CONSULTING THE ROLL...';
    clear(list);

    let open: TomeSummary[];
    try {
      open = await listTomes(school ?? undefined);
    } catch (err) {
      status.className = 'results-status results-status--error';
      status.textContent =
        err instanceof ArchiveError
          ? err.message.toUpperCase()
          : 'THE ARCHIVE DID NOT ANSWER.';
      return;
    }

    const found = await Promise.all(
      discoveries().map((cn) => resolveCallNumber(cn).catch(() => null)),
    );

    const seen = new Set(open.map((t) => t.id));
    shelf = open.map((t) => ({ ...t, sealed: false }));

    for (const tome of found) {
      if (tome === null || seen.has(tome.id)) continue;
      if (school !== null && tome.school !== school) continue;
      seen.add(tome.id);
      shelf.push({ ...tome, sealed: tome.restricted });
    }

    render();
  }

  /**
   * Ask the archive to read the bodies.
   *
   * Debounced, and the previous request is aborted rather than left to land
   * out of order behind a newer one. A call number is never sent: that is the
   * request slip, and Enter already has a job for it.
   */
  function search(): void {
    window.clearTimeout(debounce);
    const typed = query.trim();

    if (typed.length < SEARCH_MIN || CALL_NUMBER_RE.test(typed.toUpperCase())) {
      inFlight?.abort();
      inFlight = null;
      found = null;
      render();
      return;
    }

    debounce = window.setTimeout(() => {
      inFlight?.abort();
      const mine = new AbortController();
      inFlight = mine;

      void searchTomes(typed, school, mine.signal)
        .then((result) => {
          if (mine.signal.aborted) return;
          found = result.hits.map((h) => ({ ...h, sealed: false }));
          foundTotal = result.total;
          truncated = result.truncated;
          selected = 0;
          render();
        })
        .catch((err) => {
          if (err instanceof ArchiveError && err.code === 'aborted') return;
          // A failed search falls back to the local filter rather than
          // emptying the screen: the shelf is still there to look at.
          found = null;
          render();
        });
    }, SEARCH_DEBOUNCE);
  }

  /** The matched run, marked as elements. Never as markup. */
  function excerptOf(text: string): HTMLElement {
    const line = el('span', { class: 'excerpt' });
    for (const [i, part] of text.split(MARK_OPEN).entries()) {
      if (i === 0) {
        line.append(part);
        continue;
      }
      const [hit, ...rest] = part.split(MARK_CLOSE);
      line.append(el('mark', { class: 'excerpt-hit' }, hit ?? ''));
      line.append(rest.join(MARK_CLOSE));
    }
    return line;
  }

  function matches(row: Row, needle: string): boolean {
    if (needle === '') return true;
    return `${row.call_number} ${row.title} ${row.author} ${row.school}`
      .toLowerCase()
      .includes(needle);
  }

  /** One result row. `rows` is kept in the same order as these buttons. */
  function resultButton(row: Row, index: number): HTMLElement {
    return el(
      'button',
      {
        class: `result${row.sealed ? ' result--sealed' : ''}${row.excerpt ? ' result--found' : ''}`,
        type: 'button',
        role: 'option',
        'aria-selected': String(index === selected),
        onclick: () => openTome(row),
        onmouseenter: () => select(index, false),
      },
      el('span', { class: 'idx' }, String(index + 1).padStart(2, '0')),
      el('span', { class: 'call' }, row.call_number),
      el(
        'span',
        { class: 'ttl' },
        row.title,
        row.sealed ? el('span', { class: 'seal' }, 'SEALED') : null,
        row.excerpt ? excerptOf(row.excerpt) : null,
      ),
      el('span', { class: 'author' }, row.author),
      el('span', { class: 'school' }, row.school),
    );
  }

  function render(): void {
    clear(list);
    selected = Math.max(0, selected);
    if (found !== null) renderFound(found);
    else renderShelf();
  }

  /** The shelf the visitor already has, filtered in the browser. */
  function renderShelf(): void {
    const needle = query.trim().toLowerCase();
    rows = shelf.filter((row) => matches(row, needle));
    selected = Math.min(selected, Math.max(0, rows.length - 1));

    if (rows.length === 0) {
      status.className = 'results-status';
      status.textContent = CALL_NUMBER_RE.test(query.trim().toUpperCase())
        ? 'NOT ON THE OPEN SHELF. PRESS ENTER TO REQUEST IT FROM THE ROLL.'
        : 'NO VOLUME ON THE OPEN SHELF ANSWERS TO THAT.';
      return;
    }

    status.className = 'results-status';
    status.textContent = `${rows.length} VOLUME${rows.length === 1 ? '' : 'S'} ON THE SHELF`;

    rows.forEach((row, i) => list.append(el('li', {}, resultButton(row, i))));
  }

  /*
   * What the archive found, gathered by shelf.
   *
   * A librarian asking for "illusion" is answered by fifteen books across five
   * shelves, and an undifferentiated list of fifteen is a worse answer than the
   * same fifteen under their headings — it is the shelf they will actually walk
   * to. Within a shelf the order is the archive's ranking, which weights a hit
   * in the title or the author above one in the body.
   */
  function renderFound(hits: Row[]): void {
    const shelves = new Map<string, Row[]>();
    for (const hit of hits) {
      const group = shelves.get(hit.school) ?? [];
      group.push(hit);
      shelves.set(hit.school, group);
    }

    rows = [];
    if (hits.length === 0) {
      status.className = 'results-status';
      status.textContent = `NOTHING IN THE STACKS ANSWERS TO “${query.trim().toUpperCase()}”.`;
      return;
    }

    status.className = 'results-status results-status--found';
    status.textContent =
      `${foundTotal}${truncated ? '+' : ''} VOLUME${foundTotal === 1 ? '' : 'S'} ` +
      `MENTION “${query.trim().toUpperCase()}” ` +
      `ACROSS ${shelves.size} SHEL${shelves.size === 1 ? 'F' : 'VES'}`;

    for (const [name, group] of shelves) {
      list.append(
        el(
          'li',
          { class: 'results-group' },
          el('span', { class: 'results-group__name' }, name.toUpperCase()),
          el('span', { class: 'results-group__count' }, `${group.length}`),
        ),
      );
      for (const row of group) {
        list.append(el('li', {}, resultButton(row, rows.length)));
        rows.push(row);
      }
    }

    selected = Math.min(selected, Math.max(0, rows.length - 1));
    const buttons = list.querySelectorAll<HTMLElement>('.result');
    buttons.forEach((b, i) => b.setAttribute('aria-selected', String(i === selected)));
  }

  function select(index: number, scroll = true): void {
    if (rows.length === 0) return;
    selected = (index + rows.length) % rows.length;
    const buttons = list.querySelectorAll<HTMLElement>('.result');
    buttons.forEach((button, i) =>
      button.setAttribute('aria-selected', String(i === selected)),
    );
    if (scroll) buttons[selected]?.scrollIntoView({ block: 'nearest' });
    play('tick');
  }

  function openTome(row: Row): void {
    navigate(`/tome/${row.id}`);
  }

  /** A typed call number is a request slip handed across the desk. */
  async function request(callNumber: string): Promise<void> {
    status.className = 'results-status';
    status.textContent = `CHECKING THE ROLL FOR ${callNumber}...`;
    try {
      const tome = await resolveCallNumber(callNumber);
      remember(tome.call_number);
      status.className = 'results-status results-status--found';
      status.textContent = `${tome.call_number} — ${tome.title.toUpperCase()}`;
      navigate(`/tome/${tome.id}`);
    } catch (err) {
      status.className = 'results-status results-status--error';
      if (err instanceof ArchiveError) {
        status.textContent =
          err.status === 404
            ? `THE ROLL DOES NOT LIST ${callNumber}.`
            : err.message.toUpperCase();
      } else {
        status.textContent = 'THE ARCHIVE DID NOT ANSWER.';
      }
    }
  }

  input.addEventListener('input', () => {
    query = input.value;
    selected = 0;
    syncCursor();
    // The local filter redraws on this keystroke; the archive answers a beat
    // later. Typing never waits for the network.
    render();
    search();
  });

  for (const event of ['click', 'keyup', 'select', 'focus', 'blur']) {
    input.addEventListener(event, syncCursor);
  }

  // Up and Down drive the list; Left and Right are left to the text caret.
  function onKeydown(event: KeyboardEvent): void {
    if (event.key === 'ArrowDown') {
      event.preventDefault();
      select(selected + 1);
    } else if (event.key === 'ArrowUp') {
      event.preventDefault();
      select(selected - 1);
    } else if (event.key === 'Enter') {
      event.preventDefault();
      const typed = query.trim().toUpperCase();
      if (CALL_NUMBER_RE.test(typed)) {
        void request(typed);
      } else if (rows.length > 0) {
        openTome(rows[selected]!);
      }
    } else if (event.key === 'Escape') {
      input.value = '';
      query = '';
      found = null;
      window.clearTimeout(debounce);
      inFlight?.abort();
      syncCursor();
      render();
    }
  }

  element.addEventListener('keydown', onKeydown);

  // Anything typed anywhere on this screen belongs in the search field.
  function onWindowKeydown(event: KeyboardEvent): void {
    if (event.target === input) return;
    if (event.metaKey || event.ctrlKey || event.altKey) return;
    if (event.key.length === 1) input.focus();
  }

  window.addEventListener('keydown', onWindowKeydown);

  queueMicrotask(() => {
    input.focus();
    syncCursor();
  });
  void load();

  return {
    element,
    title: 'CATALOGUE',
    destroy() {
      window.clearTimeout(debounce);
      inFlight?.abort();
      window.removeEventListener('keydown', onWindowKeydown);
    },
  };
}
