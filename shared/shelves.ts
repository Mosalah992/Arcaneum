/**
 * The shelves of the Arcanaeum.
 *
 * This list is the allowlist the API validates `?shelf=` against, and the set
 * of stone tablets the catalogue draws down its left edge. Imported by both the
 * Pages Functions and the client so the two can never drift apart.
 *
 * The order is the source library's own, and it is load-bearing: a book's call
 * number takes its Roman tier from this array's index, so AR-IV-031 is the
 * thirty-first book on the fourth shelf. Reordering this list renames every
 * call number under it and orphans every discovery a reader has saved. Append,
 * do not reorder.
 *
 * The database column is still named `school`. Renaming it would mean a
 * migration and an edit in three files for no behaviour, and the column has
 * always held "which part of the library is this in" whatever it was called.
 *
 * scripts/build-seed.mjs reads this array out of this file by regex rather than
 * keeping its own copy — it cannot import TypeScript, and a hand-kept duplicate
 * of an eleven-item list is a duplicate that will drift.
 */
export const SHELVES = [
  'Biographies',
  'Faction Books',
  'Fiction',
  'History & Lore',
  'Instruction & Research',
  'Journals & Logs',
  'Notes & Letters',
  'Plays, Poetry & Riddles',
  'Politics & Law',
  'Religion & Prophecy',
  'Travel',
] as const;

export type Shelf = (typeof SHELVES)[number];

/** Case-insensitive lookup returning the canonical spelling, or null. */
export function canonicalShelf(input: string): Shelf | null {
  const needle = input.trim().toLowerCase();
  return SHELVES.find((s) => s.toLowerCase() === needle) ?? null;
}

/** Call numbers look like AR-IV-031: archive, shelf tier, accession. */
export const CALL_NUMBER_RE = /^AR-[IVXLCDM]{1,8}-\d{3}$/;

/**
 * The same shape, for finding call numbers inside a body of prose.
 *
 * A module-level regex with the `g` flag carries `lastIndex` between uses, so
 * it is only safe with `String.replace` and `String.match`, both of which reset
 * it. Never hand this to `.test()` or `.exec()` in a loop — that reads as
 * working and fails intermittently on every other call.
 */
export const CALL_NUMBER_GLOBAL_RE = /\bAR-[IVXLCDM]{1,8}-\d{3}\b/g;
