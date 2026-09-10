/**
 * The catalogue: a pixel-bitmap terminal over the shelf.
 *
 * The search field does two jobs. Typed prose filters the visible list, or —
 * past two characters — asks the archive to read the bodies. A typed call
 * number is a request slip: pressing Enter sends it to /api/resolve and the
 * roll answers with the record.
 *
 * EVERY VOLUME IS LISTED, restricted ones included, marked SEALED and shelved
 * at L1. They used to be held back and reachable only by noticing a call
 * number in a book you could already read; the College's register carries them
 * openly, with a location and a copy count, so this does too. What went with
 * that change is the `discoveries` store — a list of call numbers a visitor had
 * resolved, kept so the shelf could show them the sealed books they had found.
 * There is nothing left for it to add, and a `forget my discoveries` button
 * that forgets nothing is worse than no button.
 */

import { SHELVES, CALL_NUMBER_RE } from '../../shared/shelves';
import { clear, el } from '../lib/dom';
import {
  fetchAvailability,
  listTomes,
  resolveCallNumber,
  searchTomes,
  ArchiveError,
  type Availability,
  type TomeSummary,
} from '../lib/api';
import { heldCells, lookUp } from '../lib/holdings';
import { type Screen } from '../lib/router';
import { play } from '../lib/sound';

interface Row extends TomeSummary {
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
  /*
   * The College's register, or null until it answers — and null for good if it
   * cannot. Fetched once when the screen opens: it is one request for the whole
   * catalogue, cached for a minute by the browser, and every row reads its two
   * columns out of it. The rows render before it lands and re-render after, so
   * nothing waits on a spreadsheet.
   */
  let register: Availability | null = null;

  /*
   * How the list is ordered.
   *
   * `null` is the archive's own order — shelf, then accession — which is what
   * the call numbers are for and what a librarian walking the stacks wants.
   * Anything else is a question being asked of the list, and the two worth
   * asking are "how many do we own" and "what can I hand over right now".
   */
  type SortKey = 'call' | 'title' | 'author' | 'school' | 'copies' | 'available';
  let sortKey: SortKey | null = null;
  let sortDesc = false;

  /** Text sorts read up, quantities read down: the useful end is the big end. */
  const DEFAULT_DESC: Record<SortKey, boolean> = {
    call: false,
    title: false,
    author: false,
    school: false,
    copies: true,
    available: true,
  };

  let found: Row[] | null = null;
  let foundTotal = 0;
  let truncated = false;
  let debounce = 0;
  let inFlight: AbortController | null = null;

  const input = el('input', {
    class: 'search-input',
    // `id` and `name` even though `autocomplete` is off: a field with neither
    // is one Chrome reports as an accessibility and autofill problem, and the
    // id is what lets anything else on the page point a `for` at it.
    id: 'catalogue-search',
    name: 'q',
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

  const hint = el('span', { class: 'search-hint' }, 'UP/DOWN SELECT   ENTER CALLS A NUMBER');
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

  /*
   * The column headings, and they are NOT inside the scrolling list.
   *
   * That is the reason for `syncGutter()` below: the list reserves a scrollbar
   * gutter and the heading does not, so the two boxes are a scrollbar apart and
   * every column drifts by that much. The heading is kept outside so it does
   * not scroll away with the rows.
   */
  /*
   * One column heading, and every heading but NO. is a button.
   *
   * NO. is the row's position in whatever order is showing, so it renumbers as
   * the list moves and there is nothing to sort it by — it is a counter, not a
   * column of data.
   */
  const sortButtons = new Map<SortKey, HTMLButtonElement>();

  function heading(key: SortKey, label: string, extra = ''): HTMLElement {
    const button = el('button', {
      class: `col-sort${extra === '' ? '' : ` ${extra}`}`,
      type: 'button',
      onclick: () => sortBy(key),
    });
    button.append(el('span', { class: 'col-sort__label' }, label));
    button.append(el('span', { class: 'col-sort__mark', 'aria-hidden': 'true' }));
    sortButtons.set(key, button);
    return button;
  }

  const resultsHead = el(
    'div',
    { class: 'results-head', role: 'row' },
    el('span', {}, 'NO.'),
    heading('call', 'CALL'),
    heading('title', 'TITLE'),
    heading('copies', 'COPIES', 'col-copies'),
    heading('available', 'AVAILABLE', 'col-held'),
    heading('author', 'AUTHOR'),
    heading('school', 'SCHOOL'),
  );

  /**
   * Click a heading to sort by it; click the same one again to reverse it; a
   * third click puts the archive's own shelf order back.
   *
   * The third state is worth the extra click. Sorting is a question, and a
   * librarian needs a way to stop asking it and see the shelf as it stands
   * without hunting for which column was the original one.
   */
  function sortBy(key: SortKey): void {
    if (sortKey !== key) {
      sortKey = key;
      sortDesc = DEFAULT_DESC[key];
    } else if (sortDesc !== !DEFAULT_DESC[key]) {
      sortDesc = !sortDesc;
    } else {
      sortKey = null;
      sortDesc = false;
    }
    selected = 0;
    markSort();
    render();
  }

  /** Tell the headings, and anything reading the page aloud, where we are. */
  function markSort(): void {
    for (const [key, button] of sortButtons) {
      const active = key === sortKey;
      button.classList.toggle('col-sort--on', active);
      button.setAttribute('aria-sort', active ? (sortDesc ? 'descending' : 'ascending') : 'none');
      const mark = button.querySelector('.col-sort__mark');
      // A shape, not a colour, and not only a background: this has to be legible
      // in a screenshot and to somebody who cannot separate the two greens.
      if (mark !== null) mark.textContent = active ? (sortDesc ? '▼' : '▲') : '';
    }
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
      resultsHead,
      status,
      list,
    ),
  );

  /**
   * Hand the heading the width of the list's scrollbar.
   *
   * The rows live inside a scrolling box and the heading sits above it, so the
   * rows' content box is a scrollbar narrower than the heading's. Both use the
   * same grid template, so that difference lands entirely in `minmax(0, 1fr)`
   * and shoves every column right of the title out of line with its own
   * heading — fifteen pixels on Windows, which is exactly enough to put `22`
   * to the left of `COPIES` and `19 IN` underneath it.
   *
   * `scrollbar-gutter: stable` on the list makes the number constant whether
   * or not it overflows, so a filtered search of three rows does not shift the
   * heading back again. It is zero on overlay-scrollbar systems, where there
   * was never anything to correct.
   */
  function syncGutter(): void {
    const gutter = list.offsetWidth - list.clientWidth;
    resultsHead.style.setProperty('--gutter', `${gutter}px`);
  }

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

    shelf = open;
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
          found = result.hits;
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

  /**
   * Order a list of rows by the current sort.
   *
   * VOLUMES THE REGISTER DOES NOT LIST ALWAYS SINK, in both directions. 201 of
   * the 250 have no copy count at all, and letting them sort as zero would bury
   * the 49 that answer the question underneath them on one click and scatter
   * them through the middle on the other. "We do not stock it" is not a
   * quantity, so it is not sorted as one — it goes last and stays there.
   *
   * The tie-break is always the call number, so equal counts come out in shelf
   * order rather than in whatever order the rows happened to arrive.
   */
  function sorted(list: Row[]): Row[] {
    if (sortKey === null) return list;
    const key = sortKey;

    const quantity = key === 'copies' || key === 'available';
    const numberOf = (row: Row): number | null => {
      const holding = lookUp(row.title, register).holding;
      if (holding === null) return null;
      return key === 'copies' ? holding.copies : holding.available;
    };

    return [...list].sort((a, b) => {
      let order: number;

      if (quantity) {
        const x = numberOf(a);
        const y = numberOf(b);
        if (x === null && y === null) order = 0;
        else if (x === null) return 1; // unlisted sinks, whichever way we sort
        else if (y === null) return -1;
        else order = x - y;
      } else {
        const pick = (row: Row): string =>
          key === 'call' ? row.call_number
          : key === 'title' ? row.title
          : key === 'author' ? row.author
          : row.school;
        order = pick(a).localeCompare(pick(b), 'en', { sensitivity: 'base' });
      }

      if (order !== 0) return sortDesc ? -order : order;
      return a.call_number.localeCompare(b.call_number, 'en');
    });
  }

  /** One result row. `rows` is kept in the same order as these buttons. */
  function resultButton(row: Row, index: number): HTMLElement {
    const shelved = lookUp(row.title, register);
    // Tinted only when a copy is actually in. A title the College owns and has
    // entirely lent out is still at the top of the answer, but it is not green:
    // green is "you can hand this over", not "we own one".
    const held = shelved.state === 'in' || shelved.state === 'some';
    return el(
      'button',
      {
        class:
          `result${row.restricted ? ' result--sealed' : ''}` +
          `${row.excerpt ? ' result--found' : ''}` +
          `${row.excerpt && held ? ' result--held' : ''}`,
        type: 'button',
        role: 'option',
        'aria-selected': String(index === selected),
        onmouseenter: () => select(index, false),
      },
      el('span', { class: 'idx' }, String(index + 1).padStart(2, '0')),
      el('span', { class: 'call' }, row.call_number),
      el(
        'span',
        { class: 'ttl' },
        row.title,
        row.restricted ? el('span', { class: 'seal' }, 'SEALED') : null,
        row.excerpt ? excerptOf(row.excerpt) : null,
      ),
      ...heldCells(shelved),
      el('span', { class: 'author' }, row.author),
      el('span', { class: 'school' }, row.school),
    );
  }

  function render(): void {
    clear(list);
    selected = Math.max(0, selected);
    if (found !== null) renderFound(found);
    else renderShelf();
    // After the rows, not before: the first frame runs with an empty list and
    // measures nothing.
    syncGutter();
  }

  /** The shelf the visitor already has, filtered in the browser. */
  function renderShelf(): void {
    const needle = query.trim().toLowerCase();
    rows = sorted(shelf.filter((row) => matches(row, needle)));
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
    rows = [];
    if (hits.length === 0) {
      status.className = 'results-status';
      status.textContent = `NOTHING IN THE STACKS ANSWERS TO “${query.trim().toUpperCase()}”.`;
      return;
    }

    /*
     * WHAT THE COLLEGE ACTUALLY HOLDS COMES FIRST.
     *
     * A librarian at the desk with a reader in front of them is not asking
     * which books mention the word — they are asking which of them they can
     * put in a hand, and that is 48 volumes out of 249. Those are lifted into
     * their own group above the shelves, in the archive's ranking, and tinted
     * green when there is a copy in.
     *
     * ON THE REGISTER, not "available", is what puts a book in this group: a
     * title the College owns but has entirely lent out still belongs at the top
     * of a librarian's answer, because the answer is "we have it, it is out
     * until Tuesday" and not "we do not have it". Its AVAILABLE cell says ALL
     * OUT in red and it is not tinted, so the two cases stay distinct inside
     * the group.
     *
     * The rest keep the shelf grouping, which is the other thing a librarian
     * needs: the shelf they will actually walk to.
     */
    const atTheCollege: Row[] = [];
    const elsewhere: Row[] = [];
    for (const hit of hits) {
      (lookUp(hit.title, register).holding === null ? elsewhere : atTheCollege).push(hit);
    }

    const shelves = new Map<string, Row[]>();
    for (const hit of elsewhere) {
      const group = shelves.get(hit.school) ?? [];
      group.push(hit);
      shelves.set(hit.school, group);
    }

    const groupRow = (name: string, count: number, extra = ''): HTMLElement =>
      el(
        'li',
        { class: `results-group${extra}` },
        el('span', { class: 'results-group__name' }, name),
        el('span', { class: 'results-group__count' }, String(count)),
      );

    const place = (row: Row): void => {
      list.append(el('li', {}, resultButton(row, rows.length)));
      rows.push(row);
    };

    status.className = 'results-status results-status--found';
    const shelfCount = shelves.size + (atTheCollege.length > 0 ? 1 : 0);
    status.textContent =
      `${foundTotal}${truncated ? '+' : ''} VOLUME${foundTotal === 1 ? '' : 'S'} ` +
      `MENTION “${query.trim().toUpperCase()}”` +
      (atTheCollege.length > 0
        ? ` · ${atTheCollege.length} ON THE COLLEGE REGISTER`
        : ` ACROSS ${shelfCount} SHEL${shelfCount === 1 ? 'F' : 'VES'}`);

    /*
     * Sorted INSIDE each group, not across them.
     *
     * The groups are the answer to "where do I walk"; the sort is the answer to
     * "which of these first". Flattening the groups to honour a sort would
     * throw away the more useful of the two, so a sort reorders within
     * `ON THE SHELF AT THE COLLEGE` and within each shelf, and the groups stay
     * where they are.
     */
    if (atTheCollege.length > 0) {
      list.append(
        groupRow('ON THE SHELF AT THE COLLEGE', atTheCollege.length, ' results-group--held'),
      );
      for (const row of sorted(atTheCollege)) place(row);
    }

    for (const [name, group] of shelves) {
      list.append(groupRow(name.toUpperCase(), group.length));
      for (const row of sorted(group)) place(row);
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

  /** A typed call number is a request slip handed across the desk. */
  async function request(callNumber: string): Promise<void> {
    status.className = 'results-status';
    status.textContent = `CHECKING THE ROLL FOR ${callNumber}...`;
    try {
      const tome = await resolveCallNumber(callNumber);
      status.className = 'results-status results-status--found';
      status.textContent =
        `${tome.call_number} — ${tome.title.toUpperCase()} — ` +
        `${tome.author.toUpperCase()} — ${tome.school.toUpperCase()}`;
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

  /*
   * The register, asked for once.
   *
   * Not awaited by anything: the shelf draws with dashes in both columns and
   * fills them in when this lands, so a slow or dead spreadsheet costs the
   * catalogue nothing but two columns of em dashes. `fetchAvailability` never
   * throws.
   */
  window.addEventListener('resize', syncGutter);

  void fetchAvailability().then((answer) => {
    register = answer;
    render();
  });

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
      window.removeEventListener('resize', syncGutter);
    },
  };
}
