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
  ArchiveError,
  type TomeSummary,
} from '../lib/api';
import { discoveries, remember } from '../lib/store';
import { navigate, type Screen } from '../lib/router';
import { play } from '../lib/sound';

interface Row extends TomeSummary {
  sealed: boolean;
}

export function catalogueScreen(): Screen {
  let school: string | null = null;
  let query = '';
  let shelf: Row[] = [];
  let rows: Row[] = [];
  let selected = 0;

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

  function matches(row: Row, needle: string): boolean {
    if (needle === '') return true;
    return `${row.call_number} ${row.title} ${row.author} ${row.school}`
      .toLowerCase()
      .includes(needle);
  }

  function render(): void {
    const needle = query.trim().toLowerCase();
    rows = shelf.filter((row) => matches(row, needle));
    selected = Math.min(selected, Math.max(0, rows.length - 1));

    clear(list);

    if (rows.length === 0) {
      status.className = 'results-status';
      status.textContent = CALL_NUMBER_RE.test(query.trim().toUpperCase())
        ? 'NOT ON THE OPEN SHELF. PRESS ENTER TO REQUEST IT FROM THE ROLL.'
        : 'NO VOLUME ON THE OPEN SHELF ANSWERS TO THAT.';
      return;
    }

    status.className = 'results-status';
    status.textContent = `${rows.length} VOLUME${rows.length === 1 ? '' : 'S'} ON THE SHELF`;

    rows.forEach((row, i) => {
      const button = el(
        'button',
        {
          class: `result${row.sealed ? ' result--sealed' : ''}`,
          type: 'button',
          role: 'option',
          'aria-selected': String(i === selected),
          onclick: () => openTome(row),
          onmouseenter: () => select(i, false),
        },
        el('span', { class: 'idx' }, String(i + 1).padStart(2, '0')),
        el('span', { class: 'call' }, row.call_number),
        el(
          'span',
          { class: 'ttl' },
          row.title,
          row.sealed ? el('span', { class: 'seal' }, 'SEALED') : null,
        ),
        el('span', { class: 'author' }, row.author),
        el('span', { class: 'school' }, row.school),
      );
      list.append(el('li', {}, button));
    });
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
    render();
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
      window.removeEventListener('keydown', onWindowKeydown);
    },
  };
}
