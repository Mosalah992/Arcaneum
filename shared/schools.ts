/**
 * The canonical schools. This list is the allowlist the API validates the
 * `?school=` filter against, and the set of stone tablets the catalogue draws
 * down its left edge. Imported by both the Pages Functions and the client so
 * the two can never drift apart.
 *
 * Kept in step by hand with the copy in scripts/build-seed.mjs, which cannot
 * import TypeScript.
 */
export const SCHOOLS = [
  'Destruction',
  'Conjuration',
  'Restoration',
  'Illusion',
  'Alteration',
  'Alchemy',
  'History',
  'Daedra',
] as const;

export type School = (typeof SCHOOLS)[number];

/** Case-insensitive lookup returning the canonical spelling, or null. */
export function canonicalSchool(input: string): School | null {
  const needle = input.trim().toLowerCase();
  return SCHOOLS.find((s) => s.toLowerCase() === needle) ?? null;
}

/** Call numbers look like AR-IV-118: archive, shelf tier, accession. */
export const CALL_NUMBER_RE = /^AR-[IVXLCDM]{1,8}-\d{3}$/;

/** The same shape, for finding call numbers inside a body of prose. */
export const CALL_NUMBER_GLOBAL_RE = /\bAR-[IVXLCDM]{1,8}-\d{3}\b/g;
