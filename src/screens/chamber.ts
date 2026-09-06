/**
 * The chamber. The only three.js in the project, and the only screen that is
 * not DOM.
 *
 * A stone room, a well of magicka in the middle of it, and a sealed gate at
 * the far wall. Nothing else — no courtyard, no college, nothing outside these
 * four walls, because nothing outside them is ever in frame.
 *
 * The well is painted — a ten-frame sheet stepped by moving a texture offset.
 * Everything else here is still procedural: the stone, the runes and the motes
 * are all drawn into canvases at load, and ASSETS.md lists the plates that will
 * replace them. Every material is stock three.js. There is no custom GLSL
 * anywhere, including the motes, which are animated by writing their buffer
 * attributes from JavaScript each frame.
 *
 * The scene renders at roughly a quarter resolution and is scaled up by the
 * browser with `image-rendering: pixelated`, which is where the crunch comes
 * from. Turning that off does not make it look better; it makes it look like a
 * different project.
 */

import {
  AdditiveBlending,
  AmbientLight,
  BackSide,
  BoxGeometry,
  BufferAttribute,
  BufferGeometry,
  CanvasTexture,
  Color,
  DoubleSide,
  Mesh,
  MeshBasicMaterial,
  MeshStandardMaterial,
  NearestFilter,
  PerspectiveCamera,
  PlaneGeometry,
  PointLight,
  Points,
  PointsMaterial,
  Raycaster,
  RepeatWrapping,
  Scene,
  SRGBColorSpace,
  Vector2,
  WebGLRenderer,
  FogExp2,
  type Material,
  type Texture,
} from 'three';

import { el, prefersReducedMotion } from '../lib/dom';
import { navigate, type Screen } from '../lib/router';
import { visited } from '../lib/store';
import { play } from '../lib/sound';

/** Target internal height in pixels. Everything above this is scaled up. */
const INTERNAL_HEIGHT = 260;

/**
 * Motes drifting off the top of the well.
 *
 * The well itself is painted now, so these are no longer the effect — they are
 * the part of it that has to live in three dimensions, carrying the magicka
 * up past the flat sprite and into the dark where the room has depth.
 */
const MOTE_COUNT = 260;

/** The painted well: 10 frames, five across and two down. */
const WELL_SHEET = '/art/well.png';
const WELL_COLUMNS = 5;
const WELL_ROWS = 2;
const WELL_FRAMES = 10;
/** Frames a second. A hand-painted loop, played at a hand-painted rate. */
const WELL_FPS = 9;
/** One cell of the sheet: 1536/5 wide by 1024/2 tall. */
const WELL_ASPECT = (1536 / WELL_COLUMNS) / (1024 / WELL_ROWS);
/** How wide the painted stonework should stand in the room. */
const WELL_STONE_WIDTH = 1.6;
/** Where the well stands. The motes and the light follow it. */
const WELL_Z = -0.4;

/* Measured off this sheet: the checker runs 253 and 207, both fully neutral. */
const CHECKER_SATURATION = 8;
const CHECKER_LUMINANCE = 190;
const CHECKER_MEAN = 230;
/** How far a pixel may sit from keyed background and still count as halo. */
const HALO_RADIUS = 3;
/** Below this the pixel is stone, not glow, and is left alone. */
const HALO_LUMINANCE = 170;
/** Share of the sheet's peak saturation taken to mean "undiluted glow". */
const GLOW_FRACTION = 0.55;

/** The whole gate ceremony. The brief allows 3s. */
const CEREMONY_MS = 2600;

const ROOM = { width: 9, height: 5.2, depth: 13 };
const GATE_Z = -ROOM.depth / 2 + 0.12;

/* -- procedural textures -------------------------------------------------- */

function canvasTexture(size: number, draw: (ctx: CanvasRenderingContext2D) => void): CanvasTexture {
  const canvas = document.createElement('canvas');
  canvas.width = size;
  canvas.height = size;
  const ctx = canvas.getContext('2d');
  if (ctx !== null) {
    ctx.imageSmoothingEnabled = false;
    draw(ctx);
  }
  const texture = new CanvasTexture(canvas);
  // Nearest on both, or the upscale softens exactly what we are here for.
  texture.magFilter = NearestFilter;
  texture.minFilter = NearestFilter;
  texture.generateMipmaps = false;
  return texture;
}

/** Blocky quarried stone. Drawn in 8px cells so it reads as bitmap. */
function stoneTexture(base: number, spread: number): CanvasTexture {
  return canvasTexture(128, (ctx) => {
    for (let y = 0; y < 128; y += 8) {
      for (let x = 0; x < 128; x += 8) {
        const value = base + Math.floor((Math.random() - 0.5) * spread);
        ctx.fillStyle = `rgb(${value},${value + 2},${value + 5})`;
        ctx.fillRect(x, y, 8, 8);
      }
    }
    // Mortar courses, offset every other row like real coursed stone.
    ctx.fillStyle = 'rgba(0,0,0,0.55)';
    for (let y = 0; y < 128; y += 32) {
      ctx.fillRect(0, y, 128, 2);
      const offset = (y / 32) % 2 === 0 ? 0 : 32;
      for (let x = offset; x < 128; x += 64) ctx.fillRect(x, y, 2, 32);
    }
  });
}

/** One mote of magicka: a chunky dot with a stepped falloff, never a blur. */
function moteTexture(): CanvasTexture {
  return canvasTexture(128, (ctx) => {
    ctx.clearRect(0, 0, 128, 128);
    const steps = [
      { r: 52, a: 1 },
      { r: 38, a: 0.85 },
      { r: 24, a: 0.6 },
      { r: 12, a: 0.35 },
    ];
    // Drawn largest first, in flat rings, so the sprite has hard edges.
    for (let i = steps.length - 1; i >= 0; i--) {
      const step = steps[i]!;
      ctx.fillStyle = `rgba(255,255,255,${step.a - 0.3})`;
      ctx.beginPath();
      ctx.arc(64, 64, step.r, 0, Math.PI * 2);
      ctx.fill();
    }
    ctx.fillStyle = '#ffffff';
    ctx.beginPath();
    ctx.arc(64, 64, 10, 0, Math.PI * 2);
    ctx.fill();
  });
}

/** Wards cut into the gate. Bars and blocks only — this is a placeholder. */
function runeTexture(): CanvasTexture {
  return canvasTexture(256, (ctx) => {
    ctx.fillStyle = '#000000';
    ctx.fillRect(0, 0, 256, 256);
    ctx.fillStyle = '#ffffff';

    const bar = (x: number, y: number, w: number, h: number): void =>
      ctx.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h));

    // A ring of ward-marks around a central sigil.
    for (let i = 0; i < 8; i++) {
      const angle = (i / 8) * Math.PI * 2;
      const cx = 128 + Math.cos(angle) * 74;
      const cy = 128 + Math.sin(angle) * 74;
      bar(cx - 9, cy - 2, 18, 4);
      bar(cx - 2, cy - 9, 4, 18);
      if (i % 2 === 0) bar(cx - 7, cy - 7, 14, 3);
    }

    // The sigil: a lozenge, hollow.
    ctx.save();
    ctx.translate(128, 128);
    ctx.rotate(Math.PI / 4);
    bar(-30, -30, 60, 5);
    bar(-30, 25, 60, 5);
    bar(-30, -30, 5, 60);
    bar(25, -30, 5, 60);
    bar(-8, -8, 16, 16);
    ctx.restore();

    // Two long courses top and bottom.
    bar(24, 22, 208, 5);
    bar(24, 229, 208, 5);
  });
}

/* -- the painted well ----------------------------------------------------- */

interface KeyedSheet {
  canvas: HTMLCanvasElement;
  /** Painted width as a fraction of one cell — used to scale the quad. */
  widthFraction: number;
  /**
   * How much of a cell, measured down from its top, the painting actually
   * occupies. The rest is trimmed off in UV rather than drawn transparent —
   * it is where the glow spilled onto the checkerboard and could not be keyed
   * back off it, and cropping is the one treatment that removes it completely.
   */
  usedHeight: number;
}

/**
 * Cut the checkerboard out of the well sheet.
 *
 * THE SOURCE HAS NO ALPHA CHANNEL. It was exported as 24-bit colour with the
 * "transparent" checkerboard painted into the pixels, so the pattern arrives as
 * real grey squares with nothing behind them. A 32-bit PNG carrying a genuine
 * alpha channel deletes this entire function, and ASSETS.md asks for one.
 *
 * Until then, two passes.
 *
 * The first is a plain colour key: the checker is neutral and bright, and
 * measurement says the painting has nothing else that is both — its whites are
 * all blue, so the crystal and the beams survive a global key untouched.
 *
 * The second is the part a key cannot do. Where the glow is semi-transparent
 * the flatten composited it ONTO the checker, so those pixels are part-checker
 * and the pattern is baked into their colour; keying them leaves square holes
 * and keeping them leaves square stains. What is recoverable is an estimate:
 * the background is neutral and the glow is strongly blue, so how much
 * saturation a blended pixel has left says how much glow is in it —
 * alpha ~= saturation / saturation-of-the-pure-glow. With alpha known the grey
 * can be subtracted back out, solving C = a*F + (1-a)*B for F. It runs only on
 * pixels beside keyed ones, which is exactly the halo; solid stone is nowhere
 * near a keyed pixel and is left alone.
 */
function keyOutCheckerboard(image: HTMLImageElement): KeyedSheet | null {
  const width = image.naturalWidth;
  const height = image.naturalHeight;
  const canvas = document.createElement('canvas');
  canvas.width = width;
  canvas.height = height;

  const ctx = canvas.getContext('2d', { willReadFrequently: true });
  if (ctx === null) return null;
  ctx.drawImage(image, 0, 0);

  let field: ImageData;
  try {
    field = ctx.getImageData(0, 0, width, height);
  } catch {
    // A tainted canvas. Better a checkered well than no chamber.
    return null;
  }
  const pixels = field.data;
  const total = width * height;

  /* -- pass one: the flat background ------------------------------------- */

  const background = new Uint8Array(total);
  let purest = 1;

  for (let index = 0; index < total; index++) {
    const i = index * 4;
    const r = pixels[i]!;
    const g = pixels[i + 1]!;
    const b = pixels[i + 2]!;
    const saturation = Math.max(r, g, b) - Math.min(r, g, b);
    const luminance = (r + g + b) / 3;

    if (saturation <= CHECKER_SATURATION && luminance >= CHECKER_LUMINANCE) {
      background[index] = 1;
      pixels[i + 3] = 0;
    } else if (saturation > purest) {
      purest = saturation;
    }
  }

  /* -- pass two: the halo ------------------------------------------------ */

  /*
   * Where the glow was semi-transparent, the flatten composited it ONTO the
   * checker, so those pixels are part-checker and the pattern is baked into
   * their colour. What is recoverable is an estimate: the background is
   * neutral and the glow is strongly blue, so how much saturation a blended
   * pixel has left says how much glow is in it — alpha ~= saturation /
   * saturation-of-the-pure-glow — and with alpha known the grey can be
   * subtracted back out, solving C = a*F + (1-a)*B for F.
   *
   * It runs only within HALO_RADIUS of a keyed pixel. Growing the region by
   * connectivity instead was tried and is worse: the stonework has pale
   * highlights that are just as desaturated as the spill, so the fill walks
   * straight through them and eats the entire well.
   */
  const stride = width + 1;
  const sums = new Int32Array(stride * (height + 1));
  for (let y = 0; y < height; y++) {
    let row = 0;
    for (let x = 0; x < width; x++) {
      row += background[y * width + x]!;
      sums[(y + 1) * stride + x + 1] = sums[y * stride + x + 1]! + row;
    }
  }

  // Constant-time "is there keyed background in this square", via prefix sums.
  const nearBackground = (x: number, y: number): boolean => {
    const x0 = Math.max(0, x - HALO_RADIUS);
    const y0 = Math.max(0, y - HALO_RADIUS);
    const x1 = Math.min(width, x + HALO_RADIUS + 1);
    const y1 = Math.min(height, y + HALO_RADIUS + 1);
    return (
      sums[y1 * stride + x1]! -
        sums[y0 * stride + x1]! -
        sums[y1 * stride + x0]! +
        sums[y0 * stride + x0]! >
      0
    );
  };

  const pureGlow = purest * GLOW_FRACTION;

  for (let index = 0; index < total; index++) {
    if (background[index] === 1) continue;

    const i = index * 4;
    const r = pixels[i]!;
    const g = pixels[i + 1]!;
    const b = pixels[i + 2]!;

    // Only the bright halo needs rebuilding; the stonework is dark and opaque.
    if ((r + g + b) / 3 <= HALO_LUMINANCE) continue;

    const x = index % width;
    const y = (index - x) / width;
    if (!nearBackground(x, y)) continue;

    const saturation = Math.max(r, g, b) - Math.min(r, g, b);
    const alpha = Math.min(saturation / pureGlow, 1);

    // Below this there is more checker in the pixel than glow, and what it is
    // mostly carrying is the background it was flattened onto.
    if (alpha < 0.12) {
      pixels[i + 3] = 0;
      continue;
    }
    if (alpha < 0.996) {
      const rest = (1 - alpha) * CHECKER_MEAN;
      pixels[i] = Math.max(0, Math.min(255, (r - rest) / alpha));
      pixels[i + 1] = Math.max(0, Math.min(255, (g - rest) / alpha));
      pixels[i + 2] = Math.max(0, Math.min(255, (b - rest) / alpha));
      pixels[i + 3] = Math.round(alpha * 255);
    }
  }

  /*
   * Where the painting actually sits inside a cell.
   *
   * Measured by counting solid pixels per row and column across every cell and
   * taking the first and last that clear a threshold, rather than by taking the
   * outermost surviving pixel. A single speck of un-keyable spill would other-
   * wise define the base of the well, and the whole thing would be hung in the
   * air above the floor by however far that speck fell below the stone.
   */
  const cellWidth = Math.round(width / WELL_COLUMNS);
  const cellHeight = Math.round(height / WELL_ROWS);
  const columnMass = new Int32Array(cellWidth);
  const rowMass = new Int32Array(cellHeight);

  for (let index = 0; index < total; index++) {
    if (pixels[index * 4 + 3]! < 128) continue;
    const x = index % width;
    const y = (index - x) / width;
    columnMass[x % cellWidth]! += 1;
    rowMass[y % cellHeight]! += 1;
  }

  // A row of the stonework runs to thousands of pixels across ten cells; a
  // speck of un-keyable spill runs to a few hundred. This sits between them.
  const SOLID = 900;
  let minX = 0;
  let maxX = cellWidth - 1;
  let maxY = cellHeight - 1;
  while (minX < cellWidth - 1 && columnMass[minX]! < SOLID) minX++;
  while (maxX > minX && columnMass[maxX]! < SOLID) maxX--;
  while (maxY > 0 && rowMass[maxY]! < SOLID) maxY--;

  ctx.putImageData(field, 0, 0);

  return {
    canvas,
    widthFraction: Math.max((maxX - minX) / cellWidth, 0.05),
    usedHeight: Math.min((maxY + 1) / cellHeight, 1),
  };
}

/* -- the screen ----------------------------------------------------------- */

export function chamberScreen(): Screen {
  const canvas = el('canvas', { class: 'chamber-canvas' });
  const fade = el('div', { class: 'chamber-fade', 'aria-hidden': 'true' });
  const element = el(
    'div',
    { class: 'screen chamber' },
    canvas,
    fade,
    el(
      'p',
      { class: 'chamber-hint' },
      'THE WELL LIGHTS WHAT IT WILL',
    ),
  );

  let renderer: WebGLRenderer;
  try {
    renderer = new WebGLRenderer({ canvas, antialias: false, alpha: false });
  } catch {
    // No WebGL. The archive does not depend on the chamber; go around it.
    queueMicrotask(() => navigate('/catalogue', true));
    return { element, title: 'THE CHAMBER' };
  }

  const scene = new Scene();
  scene.background = new Color('#05060a');
  scene.fog = new FogExp2('#05060a', 0.085);

  const camera = new PerspectiveCamera(58, 1, 0.1, 60);
  camera.position.set(0, 1.72, 4.3);
  camera.lookAt(0, 1.25, GATE_Z);

  const textures: Texture[] = [];
  const materials: Material[] = [];
  const geometries: BufferGeometry[] = [];

  const keep = <T extends Material>(material: T): T => {
    materials.push(material);
    return material;
  };
  const keepGeometry = <T extends BufferGeometry>(geometry: T): T => {
    geometries.push(geometry);
    return geometry;
  };
  const keepTexture = (texture: Texture): Texture => {
    textures.push(texture);
    return texture;
  };

  /* -- the room ----------------------------------------------------------- */

  const wallMap = keepTexture(stoneTexture(30, 14)) as CanvasTexture;
  wallMap.wrapS = RepeatWrapping;
  wallMap.wrapT = RepeatWrapping;
  wallMap.repeat.set(5, 3);

  const floorMap = keepTexture(stoneTexture(24, 12)) as CanvasTexture;
  floorMap.wrapS = RepeatWrapping;
  floorMap.wrapT = RepeatWrapping;
  floorMap.repeat.set(6, 8);

  // One inverted box is the whole room. Cheaper than five planes and there is
  // nothing outside it to see.
  const room = new Mesh(
    keepGeometry(new BoxGeometry(ROOM.width, ROOM.height, ROOM.depth)),
    keep(new MeshStandardMaterial({ map: wallMap, side: BackSide, roughness: 1, metalness: 0 })),
  );
  room.position.y = ROOM.height / 2;
  scene.add(room);

  const floor = new Mesh(
    keepGeometry(new PlaneGeometry(ROOM.width, ROOM.depth)),
    keep(new MeshStandardMaterial({ map: floorMap, roughness: 1, metalness: 0 })),
  );
  floor.rotation.x = -Math.PI / 2;
  floor.position.y = 0.01;
  scene.add(floor);

  /* -- light through the cracks ------------------------------------------- */

  // Two dusty shafts leaning in from high on the walls. Flat additive planes,
  // not volumetrics: at this resolution the difference is invisible and the
  // difference in cost is not.
  const shaftMaterial = keep(
    new MeshBasicMaterial({
      color: new Color('#4a5568'),
      transparent: true,
      opacity: 0.07,
      blending: AdditiveBlending,
      depthWrite: false,
      side: DoubleSide,
    }),
  );
  const shaftGeometry = keepGeometry(new PlaneGeometry(0.5, 7.4));
  for (const side of [-1, 1]) {
    const shaft = new Mesh(shaftGeometry, shaftMaterial);
    shaft.position.set(side * 2.5, 2.7, -1.6);
    shaft.rotation.set(0.34, side * 0.5, side * 0.28);
    scene.add(shaft);
  }

  scene.add(new AmbientLight(new Color('#2a3348'), 0.34));

  /* -- the gate ----------------------------------------------------------- */

  const runeMap = keepTexture(runeTexture());

  const doorGeometry = keepGeometry(new BoxGeometry(1.62, 3.5, 0.22));
  const doors: Mesh[] = [];
  const doorMaterials: MeshStandardMaterial[] = [];

  for (const side of [-1, 1]) {
    const material = keep(
      new MeshStandardMaterial({
        color: new Color('#1d222b'),
        roughness: 0.6,
        metalness: 0.45,
        emissive: new Color('#1a5f6b'),
        emissiveMap: runeMap,
        // Nearly nothing. The gate is found by the well's light catching its
        // metal, not by being lit from within — that comes later, when it
        // answers.
        emissiveIntensity: 0.1,
      }),
    );
    const door = new Mesh(doorGeometry, material);
    door.position.set(side * 0.82, 1.76, GATE_Z);
    doorMaterials.push(material);
    doors.push(door);
    scene.add(door);
  }

  // The frame the doors sit in.
  const frameMaterial = keep(
    new MeshStandardMaterial({ color: new Color('#262b34'), roughness: 0.9, metalness: 0.15 }),
  );
  const lintel = new Mesh(keepGeometry(new BoxGeometry(4.2, 0.34, 0.4)), frameMaterial);
  lintel.position.set(0, 3.66, GATE_Z);
  scene.add(lintel);
  for (const side of [-1, 1]) {
    const jamb = new Mesh(keepGeometry(new BoxGeometry(0.38, 3.86, 0.4)), frameMaterial);
    jamb.position.set(side * 1.82, 1.83, GATE_Z);
    scene.add(jamb);
  }

  // What the pointer actually tests against: one flat rectangle over the doors.
  const gateHit = new Mesh(
    keepGeometry(new PlaneGeometry(3.3, 3.5)),
    keep(new MeshBasicMaterial({ visible: false })),
  );
  gateHit.position.set(0, 1.76, GATE_Z + 0.2);
  scene.add(gateHit);

  /* -- the well ----------------------------------------------------------- */

  /*
   * The well is painted, not modelled.
   *
   * One quad carrying a ten-frame sheet, stepped by moving the texture offset
   * — the oldest sprite trick there is, and still the one that needs no
   * shader. The camera never orbits, so a flat quad facing it is indis-
   * tinguishable from geometry, and the painting has lighting and runes on it
   * that would cost a great deal of three.js to reproduce badly.
   *
   * NearestFilter, as everywhere here: the sheet is upscaled by the same
   * quarter-resolution pass as the rest of the room and has to stay hard.
   */
  const wellMaterial = keep(
    new MeshBasicMaterial({
      transparent: true,
      depthWrite: false,
      toneMapped: false,
    }),
  );
  const well = new Mesh(keepGeometry(new PlaneGeometry(1, 1)), wellMaterial);
  well.visible = false;
  scene.add(well);

  let wellMap: Texture | null = null;
  let wellCrop = 1;
  let wellFrame = 0;
  let wellClock = 0;

  const sheet = new Image();
  sheet.decoding = 'async';
  sheet.src = WELL_SHEET;
  sheet
    .decode()
    .then(() => {
      const keyed = keyOutCheckerboard(sheet);
      if (keyed === null) return;

      const texture = new CanvasTexture(keyed.canvas);
      texture.magFilter = NearestFilter;
      texture.minFilter = NearestFilter;
      texture.generateMipmaps = false;
      texture.colorSpace = SRGBColorSpace;
      texture.repeat.set(1 / WELL_COLUMNS, keyed.usedHeight / WELL_ROWS);
      wellCrop = keyed.usedHeight;
      wellMap = keepTexture(texture);
      wellMaterial.map = texture;
      wellMaterial.needsUpdate = true;

      // Fit the quad from the painting rather than from guesswork: scale so the
      // stonework is WELL_STONE_WIDTH across, then stand it on the floor. The
      // crop puts the base at the very bottom of the quad, so that is just half
      // its height.
      const width = WELL_STONE_WIDTH / keyed.widthFraction;
      const height = (width / WELL_ASPECT) * keyed.usedHeight;
      well.scale.set(width, height, 1);
      well.position.set(0, height / 2, WELL_Z);

      well.visible = true;
      showWellFrame(0);
    })
    .catch(() => {
      // The sheet did not arrive, or the canvas refused to give its pixels
      // back. The motes and the light still describe a well, and the gate is
      // still findable, which is all the chamber owes.
    });

  /** Step the sheet. Row 0 is the top row, which in UV space is the upper half. */
  function showWellFrame(index: number): void {
    if (wellMap === null) return;
    const column = index % WELL_COLUMNS;
    const row = Math.floor(index / WELL_COLUMNS);
    // v runs up from the bottom, and the crop keeps the TOP of each cell, so
    // the offset has to skip the trimmed sliver underneath it.
    wellMap.offset.set(
      column / WELL_COLUMNS,
      (WELL_ROWS - 1 - row) / WELL_ROWS + (1 - wellCrop) / WELL_ROWS,
    );
  }

  // Sat just above the mouth so the spill clears the rim and reaches the gate.
  const wellLight = new PointLight(new Color('#4fd2e6'), 9, 20, 1.5);
  wellLight.position.set(0, 0.62, -0.4);
  scene.add(wellLight);

  // The motes. Positions, velocities and colours are plain arrays written from
  // JavaScript each frame — vertexColors is how a mote fades without a shader.
  const positions = new Float32Array(MOTE_COUNT * 3);
  const colors = new Float32Array(MOTE_COUNT * 3);
  const life = new Float32Array(MOTE_COUNT);
  const speed = new Float32Array(MOTE_COUNT);
  const angle = new Float32Array(MOTE_COUNT);
  const radius = new Float32Array(MOTE_COUNT);

  function seed(i: number, atBottom: boolean): void {
    angle[i] = Math.random() * Math.PI * 2;
    radius[i] = Math.random() ** 0.6 * 0.34;
    life[i] = atBottom ? 0 : Math.random();
    speed[i] = 0.16 + Math.random() * 0.42;
  }

  for (let i = 0; i < MOTE_COUNT; i++) seed(i, false);

  const moteGeometry = keepGeometry(new BufferGeometry());
  moteGeometry.setAttribute('position', new BufferAttribute(positions, 3));
  moteGeometry.setAttribute('color', new BufferAttribute(colors, 3));

  const moteMaterial = keep(
    new PointsMaterial({
      size: 0.085,
      map: keepTexture(moteTexture()),
      vertexColors: true,
      transparent: true,
      blending: AdditiveBlending,
      depthWrite: false,
      sizeAttenuation: true,
    }),
  );

  const motes = new Points(moteGeometry, moteMaterial);
  scene.add(motes);

  const CORE = new Color('#bdf6ff');
  const EDGE = new Color('#2e9fb4');
  const tint = new Color();

  function stepMotes(delta: number): void {
    for (let i = 0; i < MOTE_COUNT; i++) {
      life[i]! += delta * speed[i]!;
      if (life[i]! >= 1) seed(i, true);

      const t = life[i]!;
      const spin = angle[i]! + t * 2.1;
      // Narrow as it rises, so the column reads as drawn upward.
      const spreadAt = radius[i]! * (1 - t * 0.62);

      positions[i * 3] = Math.cos(spin) * spreadAt;
      // Picked up where the painted jet leaves off, and carried to the ceiling.
      positions[i * 3 + 1] = 1.95 + t * 2.6;
      positions[i * 3 + 2] = -0.4 + Math.sin(spin) * spreadAt;

      // Bright at the mouth of the well, gone by the ceiling.
      const glow = Math.max(0, 1 - t) ** 1.5;
      tint.copy(EDGE).lerp(CORE, glow);
      colors[i * 3] = tint.r * glow;
      colors[i * 3 + 1] = tint.g * glow;
      colors[i * 3 + 2] = tint.b * glow;
    }
    moteGeometry.attributes.position!.needsUpdate = true;
    moteGeometry.attributes.color!.needsUpdate = true;
  }

  /* -- sizing ------------------------------------------------------------- */

  function resize(): void {
    const width = element.clientWidth;
    const height = element.clientHeight;
    if (width === 0 || height === 0) return;

    const scale = Math.max(2, Math.round(height / INTERNAL_HEIGHT));
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
    // updateStyle false: the canvas stays stretched to the element by CSS, so
    // the small buffer is what gets scaled up.
    renderer.setPixelRatio(1);
    renderer.setSize(Math.floor(width / scale), Math.floor(height / scale), false);
  }

  /* -- pointer ------------------------------------------------------------ */

  const raycaster = new Raycaster();
  const pointer = new Vector2();
  let overGate = false;
  let ceremony = false;

  function onPointerMove(event: PointerEvent): void {
    const box = element.getBoundingClientRect();
    pointer.x = ((event.clientX - box.left) / box.width) * 2 - 1;
    pointer.y = -((event.clientY - box.top) / box.height) * 2 + 1;
    raycaster.setFromCamera(pointer, camera);
    const hit = raycaster.intersectObject(gateHit, false).length > 0;
    if (hit === overGate) return;
    overGate = hit;
    element.classList.toggle('chamber--gate', hit);
    if (hit) play('tick');
  }

  function onPointerDown(): void {
    if (overGate && !ceremony) openGate();
    else if (ceremony && visited.get()) leave();
  }

  function onKeydown(event: KeyboardEvent): void {
    if (event.key === 'Escape') {
      leave();
      return;
    }
    // The gate is opened by finding it, not by a button — but once it is
    // opening, a returning visitor may wave the ceremony through.
    if (ceremony && visited.get()) leave();
    else if (!ceremony && (event.key === 'Enter' || event.key === ' ')) openGate();
  }

  /* -- the ceremony ------------------------------------------------------- */

  let left = false;
  let leaveTimer = 0;

  function leave(): void {
    if (left) return;
    left = true;
    window.clearTimeout(leaveTimer);
    navigate('/catalogue', true);
  }

  /**
   * Rune glow, grind, the doors part, the camera goes through, black.
   *
   * Driven off the render loop's own clock rather than a tween library,
   * because everything it moves is a three.js object that only exists while
   * that loop runs. The exit is NOT driven off it: `leaveTimer` lands the
   * visitor in the catalogue whether or not a single further frame is drawn.
   */
  function openGate(): void {
    if (ceremony) return;
    ceremony = true;
    element.classList.add('chamber--opening');
    play('unlock');
    window.setTimeout(() => play('grind'), 320);
    leaveTimer = window.setTimeout(leave, CEREMONY_MS);
  }

  let ceremonyAt = 0;

  function stepCeremony(delta: number): void {
    ceremonyAt += delta * 1000;
    const t = Math.min(ceremonyAt / CEREMONY_MS, 1);

    // 0.00–0.18  the wards take the light
    const glow = Math.min(t / 0.18, 1);
    for (const material of doorMaterials) {
      material.emissiveIntensity = 0.1 + glow * 2.8;
    }

    // 0.14–0.30  the grind, before anything moves
    if (t > 0.14 && t < 0.3) {
      camera.position.x = (Math.random() - 0.5) * 0.035;
    } else {
      camera.position.x = 0;
    }

    // 0.28–0.66  the doors part
    const part = Math.max(0, Math.min((t - 0.28) / 0.38, 1));
    const eased = part * part * (3 - 2 * part);
    doors[0]!.position.x = -0.82 - eased * 1.45;
    doors[1]!.position.x = 0.82 + eased * 1.45;

    // 0.46–1.00  the camera goes through
    //
    // Far enough to actually pass the gate plane at z = GATE_Z, not merely to
    // approach it. It ends outside the room, which is only safe because the
    // fade below is at full black by the time it gets there.
    const push = Math.max(0, Math.min((t - 0.46) / 0.54, 1));
    camera.position.z = 4.3 - push * push * 12;

    // 0.72–1.00  black
    fade.style.opacity = String(Math.max(0, Math.min((t - 0.72) / 0.28, 1)));
  }

  /* -- the loop ----------------------------------------------------------- */

  let frame = 0;
  let last = performance.now();
  let flicker = 0;

  function tick(now: number): void {
    frame = requestAnimationFrame(tick);
    const delta = Math.min((now - last) / 1000, 0.05);
    last = now;

    stepMotes(delta);

    wellClock += delta;
    if (wellClock >= 1 / WELL_FPS) {
      wellClock %= 1 / WELL_FPS;
      wellFrame = (wellFrame + 1) % WELL_FRAMES;
      showWellFrame(wellFrame);
    }

    // The well breathes. Two frequencies so it never reads as a loop.
    flicker += delta;
    wellLight.intensity =
      6.5 + Math.sin(flicker * 2.3) * 0.85 + Math.sin(flicker * 7.1) * 0.35;

    if (ceremony) stepCeremony(delta);

    renderer.render(scene, camera);
  }

  const onResize = (): void => resize();

  element.addEventListener('pointermove', onPointerMove);
  element.addEventListener('pointerdown', onPointerDown);
  window.addEventListener('keydown', onKeydown);
  window.addEventListener('resize', onResize);

  // The element is not in the document yet when this runs.
  requestAnimationFrame(() => {
    resize();
    frame = requestAnimationFrame(tick);
  });

  return {
    element,
    title: 'THE CHAMBER',
    destroy() {
      cancelAnimationFrame(frame);
      window.clearTimeout(leaveTimer);
      element.removeEventListener('pointermove', onPointerMove);
      element.removeEventListener('pointerdown', onPointerDown);
      window.removeEventListener('keydown', onKeydown);
      window.removeEventListener('resize', onResize);

      // Nothing here is collected on its own — GPU allocations outlive the
      // JavaScript that made them, and a chamber left running behind the
      // catalogue is a chamber still drawing 900 sprites a frame.
      for (const geometry of geometries) geometry.dispose();
      for (const material of materials) material.dispose();
      for (const texture of textures) texture.dispose();
      scene.clear();
      renderer.dispose();
      renderer.forceContextLoss();
    },
  };
}

/** True when the chamber should be skipped rather than entered. */
export const chamberSuppressed = (): boolean => prefersReducedMotion();
