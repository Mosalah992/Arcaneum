/**
 * The illuminations.
 *
 * One painted sheet holds every ornament the volumes use. Rather than cut it
 * into files, the elements are addressed as sprites: each entry below is the
 * bounding box of one painted thing, measured off the sheet, and the reader
 * scales and offsets the shared background image to show just that box.
 *
 * The sheet has a real alpha channel, so the ornaments sit on the parchment
 * with nothing behind them and no keying is needed — unlike the well sheet,
 * which arrived flattened. If the sheet is repainted, only these numbers move.
 */

export const SHEET = '/art/rubrication.png';
const SHEET_WIDTH = 1536;
const SHEET_HEIGHT = 1024;

export interface Ornament {
  x: number;
  y: number;
  w: number;
  h: number;
}

/** The dragon and its vine. Set above the title on the opening leaf. */
export const HEADPIECE: Ornament = { x: 448, y: 18, w: 813, h: 257 };

/** A hound running a vine, used to close a volume. */
export const TAILPIECE: Ornament = { x: 17, y: 827, w: 692, h: 186 };

/**
 * One painted device per school, so a volume is recognisable from its title
 * page before a word of it is read.
 */
export const BY_SCHOOL: Record<string, Ornament> = {
  Destruction: { x: 359, y: 191, w: 239, h: 246 },
  Conjuration: { x: 943, y: 270, w: 292, h: 288 },
  Restoration: { x: 602, y: 217, w: 314, h: 313 },
  Illusion: { x: 765, y: 893, w: 293, h: 123 },
  Alteration: { x: 1202, y: 431, w: 161, h: 409 },
  Alchemy: { x: 258, y: 445, w: 311, h: 397 },
  History: { x: 1090, y: 795, w: 294, h: 225 },
  Daedra: { x: 905, y: 599, w: 262, h: 270 },
};

/**
 * Inline style showing one ornament at a given height.
 *
 * The whole sheet is scaled so the chosen box comes out at `height`, then
 * shifted so that box lands in the element. Sizes are in em rather than px so
 * an ornament keeps its proportion to the type it sits with when the page is
 * laid out larger or smaller.
 */
export function ornamentStyle(ornament: Ornament, height: number): string {
  const scale = height / ornament.h;
  return [
    `width:${(ornament.w * scale).toFixed(3)}em`,
    `height:${height}em`,
    `background-size:${(SHEET_WIDTH * scale).toFixed(3)}em ${(SHEET_HEIGHT * scale).toFixed(3)}em`,
    `background-position:${(-ornament.x * scale).toFixed(3)}em ${(-ornament.y * scale).toFixed(3)}em`,
  ].join(';');
}
