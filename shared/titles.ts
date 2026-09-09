/**
 * How a title in the College's register is matched to a volume in the archive.
 *
 * SHARED, because both ends have to agree exactly. The Worker keys the
 * register's holdings by these functions and the browser looks them up by the
 * same ones; two copies of "close enough" drifting apart would show as books
 * quietly reporting no holdings, with nothing to say why.
 */

/**
 * Case, punctuation, curly quotation marks and a leading article are all noise;
 * what is left is enough to pair "The Book of Daedra" with "book of daedra".
 *
 * Deliberately NOT clever. Fuzzy matching would pair things that are not the
 * same book and there would be no way to see that it had, whereas an unmatched
 * title is visible and a librarian can fix a spelling.
 */
export function normaliseTitle(title: string): string {
  return title
    .toLowerCase()
    .replace(/[‘’“”]/g, "'")
    .replace(/[^a-z0-9' ]+/g, ' ')
    .replace(/^(the|a|an)\s+/, '')
    .replace(/\s+/g, ' ')
    .trim();
}

/** The volume numbers the register actually writes, in the forms it writes them. */
const VOLUME = /[,.]\s*(v|vol|volume|book|part)\s*\.?\s*\d+\s*$/i;

/** A register title with its volume number taken off. */
export const withoutVolume = (title: string): string => title.replace(VOLUME, '');

/**
 * A volume of a work, reduced to the work.
 *
 * The two lists disagree about what a book IS, and this is the disagreement:
 * the register is a shelf list and counts physical volumes — `The Real
 * Barenziah, v1` through `v5`, `A Dance in Fire, v1` through `v7`, `Songs of
 * the Return, Vol 19` — while the catalogue is a reading list and holds each
 * work as one entry, `The Real Barenziah`. Without this, 37 of the 249 volumes
 * matched the register and everything in a series read as unheld; with it, 48.
 *
 * STILL NOT FUZZY. It removes a trailing volume number written in one of the
 * forms above, and nothing else. `Mystery of Talara, v 1`, `Palla, volume 1`
 * and `Argonian Account, Book 1` all reduce. `2920, Morning Star, v1` reduces
 * to `2920, Morning Star`, which the archive files inside one volume called
 * `2920, Last Year of the First Era`, and `Arcana Restored` is the register's
 * name for `Arcana Restored: A Handbook` — those two the register and the
 * catalogue genuinely name differently, and they are reported as unmatched so
 * a librarian can decide. Nothing here guesses.
 */
export const workKey = (title: string): string => normaliseTitle(withoutVolume(title));
