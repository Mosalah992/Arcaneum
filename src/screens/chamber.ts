/**
 * The chamber. The only three.js in the project, and the only screen that is
 * not DOM.
 *
 * A stone room, magicka welling up out of the floor in the middle of it, and a
 * sealed gate at the far wall. Nothing else — no courtyard, no college, nothing
 * outside these four walls, because nothing outside them is ever in frame.
 *
 * EVERYTHING IS PROCEDURAL. The stone, the runes and the motes are all drawn
 * into canvases at load; ASSETS.md lists the plates that will replace them.
 * Every material is stock three.js, and there is no custom GLSL anywhere —
 * including the magicka, which is animated by writing its buffer attributes
 * from JavaScript each frame.
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
 * The motes are the magicka, and now they are all of it.
 *
 * With the painted well gone there is nothing standing in the middle of the
 * room: the magicka wells straight up out of the floor. Animated point sprites
 * on a nearest-filtered texture with additive blending, their positions and
 * colours written from JavaScript each frame — no shader anywhere.
 */
const MOTE_COUNT = 900;

/** Where the magicka rises. The light follows it. */
const WELL_Z = -0.4;

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
      'THE LIGHT SHOWS WHAT IT WILL',
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

  /* -- the magicka -------------------------------------------------------- */

  /*
   * The light the magicka throws.
   *
   * It stays whatever else goes, because it is the only thing that finds the
   * gate. The brief has no ENTER button — the gate is nearly invisible and is
   * revealed by this light alone — so removing it would leave a dark room with
   * a door nobody can see.
   */
  const wellLight = new PointLight(new Color('#4fd2e6'), 9, 20, 1.5);
  wellLight.position.set(0, 0.62, WELL_Z);
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
    radius[i] = Math.random() ** 0.6 * 0.78;
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
      positions[i * 3 + 1] = 0.06 + t * 3.4;
      positions[i * 3 + 2] = WELL_Z + Math.sin(spin) * spreadAt;

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

  let sizedWidth = 0;
  let sizedHeight = 0;

  /**
   * Idempotent, and called from the loop as well as from the observer.
   *
   * The observer alone is not enough: it is delivered as part of the browser's
   * rendering steps, and a backgrounded or throttled tab can withhold it
   * indefinitely — which leaves the camera on its placeholder aspect and the
   * renderer at its default 300x150 buffer for the life of the scene. Checking
   * two properties per frame is cheaper than being wrong about the shape of the
   * room, and the early return means nothing is reallocated unless it changed.
   */
  function resize(): void {
    const width = element.clientWidth;
    const height = element.clientHeight;
    if (width === 0 || height === 0) return;
    if (width === sizedWidth && height === sizedHeight) return;
    sizedWidth = width;
    sizedHeight = height;

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

    /*
     * World matrices, explicitly, before casting.
     *
     * Raycasting reads `matrixWorld`, which three.js only refreshes as part of
     * rendering. If a pointer event is handled before the loop has drawn — or
     * against a scene whose loop is not running — the cast is made against an
     * untransformed camera and an untransformed plane sitting at the origin.
     * That is not a hypothetical: it put the gate's hit area over the floor,
     * two units below the doors, with the hand cursor appearing on empty flags
     * and nothing happening over the gate itself.
     */
    camera.updateMatrixWorld();
    gateHit.updateMatrixWorld();
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

    resize();

    stepMotes(delta);

    // The well breathes. Two frequencies so it never reads as a loop.
    flicker += delta;
    wellLight.intensity =
      6.5 + Math.sin(flicker * 2.3) * 0.85 + Math.sin(flicker * 7.1) * 0.35;

    if (ceremony) stepCeremony(delta);

    renderer.render(scene, camera);
  }

  /*
   * Sized by a ResizeObserver, not by a frame callback.
   *
   * This used to call resize() once from a requestAnimationFrame. That call
   * can land before the element has been laid out, and resize() bails on a
   * zero-sized element — so the camera kept its placeholder aspect of 1 for
   * the life of the scene. The room still drew, which is why it went unnoticed,
   * but the projection used to pick the gate was not the projection it was
   * drawn with, and the hand cursor appeared over the floor instead of over the
   * doors. An observer fires when the element actually has a size, however late
   * that is, and again whenever it changes.
   */
  const observer = new ResizeObserver(() => resize());
  observer.observe(element);

  const onResize = (): void => resize();

  element.addEventListener('pointermove', onPointerMove);
  element.addEventListener('pointerdown', onPointerDown);
  window.addEventListener('keydown', onKeydown);
  window.addEventListener('resize', onResize);

  frame = requestAnimationFrame(tick);

  return {
    element,
    title: 'THE CHAMBER',
    destroy() {
      cancelAnimationFrame(frame);
      observer.disconnect();
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
