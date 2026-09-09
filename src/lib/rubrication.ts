/**
 * The illuminations.
 *
 * One painted sheet holds every ornament the volumes use, and the elements on
 * it interleave: the sun's corner reaches into the rectangle around the dragon
 * border, a vine crosses behind the stag. So an ornament CANNOT simply be a
 * crop. Cropping showed whatever else happened to fall inside the rectangle,
 * sliced off square at its edge — the hard edges you could see on everything
 * except the raven, which is the one element with nothing near it.
 *
 * Instead each ornament is isolated: the sheet is labelled into connected runs
 * of opaque pixels once, and an ornament is the run that best fills its
 * recorded box. Only that run's own pixels are copied out, so a neighbour
 * passing through the box is left behind rather than cut in half. The result
 * is cached as a data URL and handed to the reader.
 *
 * The boxes below are measured off the current sheet and only have to be close
 * enough to identify the right run. Repaint the sheet and they can be re-
 * measured; nothing else needs to change.
 */

const SHEET = '/art/rubrication.png';

/** Opaque enough to belong to an element rather than to its antialiasing. */
const SOLID_ALPHA = 40;

/** Runs smaller than this are speckle, not ornament. */
const MIN_AREA = 3000;

export interface Box {
  x: number;
  y: number;
  w: number;
  h: number;
}

/** The dragon and its vine. Set above the title on the opening leaf. */
export const HEADPIECE: Box = { x: 448, y: 18, w: 813, h: 257 };

/** A hound running a vine, used to close a volume. */
export const TAILPIECE: Box = { x: 17, y: 827, w: 692, h: 186 };

/*
 * The devices on the sheet, named for what they are rather than for where they
 * are used, because three of them are used twice.
 */
const SUN: Box = { x: 359, y: 191, w: 239, h: 246 };
const RAVEN: Box = { x: 943, y: 270, w: 292, h: 288 };
const HARE: Box = { x: 602, y: 217, w: 314, h: 313 };
const SNAIL: Box = { x: 765, y: 893, w: 293, h: 123 };
const STAG: Box = { x: 1202, y: 431, w: 161, h: 409 };
const SCHOLAR: Box = { x: 258, y: 445, w: 311, h: 397 };
const COMPASS: Box = { x: 1090, y: 795, w: 294, h: 225 };
const DRAGON: Box = { x: 905, y: 599, w: 262, h: 270 };

/**
 * One painted device per shelf, so a volume is recognisable from its title page
 * before a word of it is read.
 *
 * THE CONVENTION, stated because eleven shelves are being served by eight
 * painted devices and the pairings are otherwise arbitrary:
 *
 *   scholar  a life, told         raven    a faction, watchful and secret
 *   hare     a tale being told    compass  a record of where and when
 *   sun      knowledge and light  snail    a private paper, slowly kept
 *   dragon   the numinous         stag     a journey
 *
 * Three shelves borrow a device that already belongs to another — Notes &
 * Letters takes the snail, Plays takes the hare, Politics takes the compass.
 * They are borrowing, not sharing a meaning, and ASSETS.md lists the three
 * plates that would end it. Until those exist, two shelves show the same mark,
 * which is a smaller wrong than a title page with nothing on it.
 */
export const BY_SHELF: Record<string, Box> = {
  Biographies: SCHOLAR,
  'Faction Books': RAVEN,
  Fiction: HARE,
  'History & Lore': COMPASS,
  'Instruction & Research': SUN,
  'Journals & Logs': SNAIL,
  'Notes & Letters': SNAIL,
  'Plays, Poetry & Riddles': HARE,
  'Politics & Law': COMPASS,
  'Religion & Prophecy': DRAGON,
  Travel: STAG,
};

export interface Cutout {
  /** A PNG of this ornament alone, on transparency. */
  url: string;
  /** Width over height, for sizing before or after it arrives. */
  aspect: number;
}

interface Run {
  id: number;
  box: Box;
  area: number;
}

interface Sheet {
  runs: Run[];
  /** Which run each pixel belongs to, or 0. */
  labels: Int32Array;
  pixels: Uint8ClampedArray;
  width: number;
}

let sheet: Promise<Sheet | null> | null = null;
const cache = new Map<string, Promise<Cutout | null>>();

/**
 * Label the sheet into connected runs of opaque pixels. Done once per session.
 *
 * A label MAP rather than a list of pixels per run. Collecting each run's
 * members into its own array was the obvious way to write this and it made the
 * whole thing take seconds — a million and a half array pushes and the garbage
 * that comes with them, for information already implied by the map. Here every
 * pixel is written exactly once, and a cut-out reads back only the rows its own
 * bounding box covers.
 */
function readSheet(): Promise<Sheet | null> {
  if (sheet !== null) return sheet;

  sheet = (async () => {
    /*
     * Loaded through `onload`, not `decode()`.
     *
     * `image.decode()` never settled here — neither resolving nor rejecting —
     * and left every ornament permanently blank with nothing in the console to
     * say why. `onload` is the older contract and it fires.
     */
    const image = await new Promise<HTMLImageElement | null>((resolve) => {
      const img = new Image();
      img.onload = () => resolve(img);
      img.onerror = () => resolve(null);
      img.src = SHEET;
    });
    if (image === null) return null;

    const width = image.naturalWidth;
    const height = image.naturalHeight;
    const canvas = document.createElement('canvas');
    canvas.width = width;
    canvas.height = height;
    const ctx = canvas.getContext('2d', { willReadFrequently: true });
    if (ctx === null) return null;
    ctx.drawImage(image, 0, 0);

    const pixels = ctx.getImageData(0, 0, width, height).data;
    const total = width * height;
    const labels = new Int32Array(total);
    const stack = new Int32Array(total);
    const runs: Run[] = [];
    let next = 0;

    for (let start = 0; start < total; start++) {
      if (labels[start] !== 0 || pixels[start * 4 + 3]! <= SOLID_ALPHA) continue;

      const id = ++next;
      let top = 0;
      stack[top++] = start;
      labels[start] = id;

      let area = 0;
      let x0 = width;
      let y0 = height;
      let x1 = 0;
      let y1 = 0;

      while (top > 0) {
        const index = stack[--top]!;
        area++;
        const x = index % width;
        const y = (index - x) / width;
        if (x < x0) x0 = x;
        if (x > x1) x1 = x;
        if (y < y0) y0 = y;
        if (y > y1) y1 = y;

        if (x > 0 && labels[index - 1] === 0 && pixels[(index - 1) * 4 + 3]! > SOLID_ALPHA) {
          labels[index - 1] = id;
          stack[top++] = index - 1;
        }
        if (x < width - 1 && labels[index + 1] === 0 && pixels[(index + 1) * 4 + 3]! > SOLID_ALPHA) {
          labels[index + 1] = id;
          stack[top++] = index + 1;
        }
        if (y > 0 && labels[index - width] === 0 && pixels[(index - width) * 4 + 3]! > SOLID_ALPHA) {
          labels[index - width] = id;
          stack[top++] = index - width;
        }
        if (
          y < height - 1 &&
          labels[index + width] === 0 &&
          pixels[(index + width) * 4 + 3]! > SOLID_ALPHA
        ) {
          labels[index + width] = id;
          stack[top++] = index + width;
        }
      }

      if (area >= MIN_AREA) {
        runs.push({ id, box: { x: x0, y: y0, w: x1 - x0 + 1, h: y1 - y0 + 1 }, area });
      }
    }

    return { runs, labels, pixels, width };
  })().catch(() => null);

  return sheet;
}

/** How much two boxes agree, 0..1. Used to match a run to a recorded box. */
function overlap(a: Box, b: Box): number {
  const w = Math.max(0, Math.min(a.x + a.w, b.x + b.w) - Math.max(a.x, b.x));
  const h = Math.max(0, Math.min(a.y + a.h, b.y + b.h) - Math.max(a.y, b.y));
  const shared = w * h;
  return shared / (a.w * a.h + b.w * b.h - shared);
}

/**
 * One ornament, alone, as a PNG data URL.
 *
 * Cached by name: the reader asks for the same three or four ornaments on every
 * volume it opens, and the sheet is only labelled once per session.
 */
export function cutout(name: string, box: Box): Promise<Cutout | null> {
  const existing = cache.get(name);
  if (existing !== undefined) return existing;

  const made = readSheet().then((loaded) => {
    if (loaded === null) return null;

    let best: Run | null = null;
    let bestScore = 0;
    for (const run of loaded.runs) {
      const score = overlap(run.box, box);
      if (score > bestScore) {
        bestScore = score;
        best = run;
      }
    }
    // Nothing on the sheet answers to that box any more; draw nothing rather
    // than draw the wrong thing.
    if (best === null || bestScore < 0.2) return null;

    const { labels, pixels, width } = loaded;
    const { x, y, w, h } = best.box;
    const id = best.id;

    const cut = document.createElement('canvas');
    cut.width = w;
    cut.height = h;
    const out = cut.getContext('2d');
    if (out === null) return null;

    // Only this run's own pixels. A neighbour crossing the box is left behind
    // rather than sliced off at its edge, which is the whole point.
    const field = out.createImageData(w, h);
    for (let row = 0; row < h; row++) {
      const from = (y + row) * width + x;
      const to = row * w;
      for (let column = 0; column < w; column++) {
        if (labels[from + column] !== id) continue;
        const a = (from + column) * 4;
        const b = (to + column) * 4;
        field.data[b] = pixels[a]!;
        field.data[b + 1] = pixels[a + 1]!;
        field.data[b + 2] = pixels[a + 2]!;
        field.data[b + 3] = pixels[a + 3]!;
      }
    }
    out.putImageData(field, 0, 0);

    return { url: cut.toDataURL('image/png'), aspect: w / h };
  });

  cache.set(name, made);
  return made;
}
