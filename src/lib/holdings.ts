/**
 * Whether the College can actually hand you the book.
 *
 * TWO COLUMNS, because they answer two different questions. `COPIES` is how
 * many the College owns and does not change from one afternoon to the next;
 * `AVAILABLE` is how many are on the shelf right now, and it moves every time a
 * librarian signs one out. A single column would have to pick one of those and
 * lose the other, and a reader asking "can I take it today" and a librarian
 * asking "how many do we own" both need an answer.
 *
 * The catalogue is a reading list of 249 texts; the register is a shelf list of
 * what the College physically holds — 96 works plus 8 in the restricted press,
 * 48 of which answer to a volume here. The rest are not *out*: they are not
 * stocked, and that has to look different from a book that is stocked and lent,
 * because the answer to the reader is different. "We do not hold that" against
 * "it is out until Tuesday".
 *
 * COLOUR IS NEVER THE ONLY CHANNEL. The four states have four shapes of words —
 * `22 IN`, `19 IN` beside a copy count of 22, `ALL OUT`, `—` — so they are told
 * apart on a monochrome screen, in a screenshot, and by a librarian who cannot
 * separate the greens from the reds. Colour is a second reading of the same
 * fact, never the fact.
 */

import { normaliseTitle, workKey } from '../../shared/titles';
import { el } from './dom';
import type { Availability, Holding } from './api';

export type Held = 'in' | 'some' | 'out' | 'unlisted';

export interface Shelved {
  state: Held;
  /** The COPIES cell. */
  copies: string;
  /** The AVAILABLE cell. */
  label: string;
  /** The whole of it in a sentence, for the tooltip and for screen readers. */
  detail: string;
  holding: Holding | null;
}

const NOT_HELD: Shelved = {
  state: 'unlisted',
  copies: '—',
  label: '—',
  detail:
    'Not on the College’s register. The archive holds the text; the shelves do not hold a copy.',
  holding: null,
};

/**
 * Look a volume up in the register.
 *
 * Exact title first, then the work the title belongs to, which is what pairs
 * one `The Real Barenziah` here with five `The Real Barenziah, vN` there. Both
 * keys come from `shared/titles.ts`, the same module the Worker keys the
 * register with, so the two ends cannot drift apart.
 */
export function lookUp(title: string, register: Availability | null): Shelved {
  if (register === null || !register.configured) return NOT_HELD;

  const holding =
    register.holdings[normaliseTitle(title)] ?? register.holdings[workKey(title)];
  if (holding === undefined) return NOT_HELD;

  const copies = String(holding.copies);
  const where = holding.location === '' ? 'unshelved' : `at ${holding.location}`;
  const across = holding.volumes > 1 ? `${holding.volumes} volumes, ` : '';
  const plural = holding.copies === 1 ? 'copy' : 'copies';

  if (holding.available <= 0) {
    return {
      state: 'out',
      copies,
      label: 'ALL OUT',
      detail: `${holding.title} — ${across}all ${holding.copies} ${plural} out, ${where}.`,
      holding,
    };
  }

  return {
    state: holding.out > 0 ? 'some' : 'in',
    copies,
    label: `${holding.available} IN`,
    detail:
      `${holding.title} — ${across}${holding.available} of ${holding.copies} ` +
      `on the shelf ${where}` +
      (holding.out > 0 ? `, ${holding.out} out.` : '.'),
    holding,
  };
}

/** The two cells, in grid order. Both carry the sentence for anyone who needs it. */
export function heldCells(shelved: Shelved): HTMLElement[] {
  return [
    el('span', { class: `copies copies--${shelved.state}`, title: shelved.detail }, shelved.copies),
    el(
      'span',
      { class: `held held--${shelved.state}`, title: shelved.detail, 'aria-label': shelved.detail },
      shelved.label,
    ),
  ];
}
