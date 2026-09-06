/**
 * The sound layer.
 *
 * The four cues — hover tick, page turn, stone grind, gate unlock — are
 * synthesised in Web Audio rather than loaded. They are a few oscillators and
 * a noise buffer, which is what an 8-bit cue is anyway; it costs no bytes, no
 * request can fail, and there is no placeholder art to swap out later. The
 * files that could replace them are listed in ASSETS.md all the same, and
 * `play()` is the only thing that would need to change.
 *
 * NOTHING PLAYS UNTIL A GESTURE. The AudioContext is not even constructed
 * until the visitor has touched the page, so nothing is suspended-and-resumed
 * behind their back and no browser has anything to complain about.
 *
 * EVERY PATH IS OPTIONAL. Web Audio missing, the context refusing to start,
 * the theme failing to download — each is caught and dropped. Silence is a
 * degraded archive, not a broken one.
 */

import { muted, music } from './store';

/**
 * What plays where. The archive has one voice and the volumes have another —
 * reading a tome puts you somewhere quieter and stranger than the catalogue.
 */
const TRACKS = {
  archive: '/audio/librarytheme.mp3',
  reading: '/audio/darkwave.mp3',
} as const;

export type Track = keyof typeof TRACKS;

const THEME_VOLUME = 0.3;

export type Cue = 'tick' | 'page' | 'grind' | 'unlock';

let ctx: AudioContext | null = null;
let master: GainNode | null = null;
let noise: AudioBuffer | null = null;
let gestured = false;

const themes = new Map<Track, HTMLAudioElement>();
let current: Track = 'archive';

/** White noise, made once, reused by the paper and stone cues. */
function noiseBuffer(context: AudioContext): AudioBuffer {
  if (noise !== null) return noise;
  const length = Math.floor(context.sampleRate * 1.2);
  const buffer = context.createBuffer(1, length, context.sampleRate);
  const data = buffer.getChannelData(0);
  for (let i = 0; i < length; i++) data[i] = Math.random() * 2 - 1;
  noise = buffer;
  return buffer;
}

function audio(): AudioContext | null {
  if (!gestured) return null;
  if (ctx !== null) return ctx;
  try {
    const Ctor = window.AudioContext ?? (window as unknown as {
      webkitAudioContext?: typeof AudioContext;
    }).webkitAudioContext;
    if (Ctor === undefined) return null;
    ctx = new Ctor();
    master = ctx.createGain();
    master.gain.value = 0.5;
    master.connect(ctx.destination);
  } catch {
    ctx = null;
  }
  return ctx;
}

/* -- the cues ------------------------------------------------------------- */

function blip(
  context: AudioContext,
  out: GainNode,
  type: OscillatorType,
  from: number,
  to: number,
  at: number,
  length: number,
  level: number,
): void {
  const osc = context.createOscillator();
  const gain = context.createGain();
  osc.type = type;
  osc.frequency.setValueAtTime(from, at);
  if (to !== from) osc.frequency.exponentialRampToValueAtTime(to, at + length);
  // A hard attack and a short decay: this is a chip, not an instrument.
  gain.gain.setValueAtTime(0, at);
  gain.gain.linearRampToValueAtTime(level, at + 0.006);
  gain.gain.exponentialRampToValueAtTime(0.0001, at + length);
  osc.connect(gain);
  gain.connect(out);
  osc.start(at);
  osc.stop(at + length + 0.02);
}

function rush(
  context: AudioContext,
  out: GainNode,
  at: number,
  length: number,
  level: number,
  filterType: BiquadFilterType,
  from: number,
  to: number,
): void {
  const source = context.createBufferSource();
  source.buffer = noiseBuffer(context);
  const filter = context.createBiquadFilter();
  filter.type = filterType;
  filter.frequency.setValueAtTime(from, at);
  filter.frequency.exponentialRampToValueAtTime(to, at + length);
  filter.Q.value = 1.1;
  const gain = context.createGain();
  gain.gain.setValueAtTime(0, at);
  gain.gain.linearRampToValueAtTime(level, at + length * 0.18);
  gain.gain.exponentialRampToValueAtTime(0.0001, at + length);
  source.connect(filter);
  filter.connect(gain);
  gain.connect(out);
  source.start(at);
  source.stop(at + length + 0.02);
}

export function play(cue: Cue): void {
  if (muted.get()) return;
  const context = audio();
  if (context === null || master === null) return;

  try {
    const at = context.currentTime;
    switch (cue) {
      case 'tick':
        // A cursor passing over something that answers.
        blip(context, master, 'square', 1750, 1750, at, 0.028, 0.055);
        break;

      case 'page':
        // Paper, which is noise and nothing else.
        rush(context, master, at, 0.24, 0.12, 'bandpass', 2600, 700);
        break;

      case 'grind':
        // Stone on stone: low noise under a detuned pair.
        rush(context, master, at, 0.85, 0.19, 'lowpass', 900, 160);
        blip(context, master, 'sawtooth', 74, 52, at, 0.8, 0.1);
        blip(context, master, 'sawtooth', 71, 49, at + 0.02, 0.78, 0.08);
        break;

      case 'unlock':
        // The wards answering, four steps up.
        blip(context, master, 'square', 392, 392, at, 0.1, 0.09);
        blip(context, master, 'square', 523, 523, at + 0.09, 0.1, 0.09);
        blip(context, master, 'square', 659, 659, at + 0.18, 0.12, 0.09);
        blip(context, master, 'triangle', 1046, 1568, at + 0.28, 0.5, 0.07);
        break;
    }
  } catch {
    /* a cue that will not sound is not worth an error */
  }
}

/* -- the theme ------------------------------------------------------------ */

function themeElement(track: Track): HTMLAudioElement | null {
  const existing = themes.get(track);
  if (existing !== undefined) return existing;
  try {
    const element = new Audio(TRACKS[track]);
    element.loop = true;
    element.volume = THEME_VOLUME;
    element.preload = 'none';

    /*
     * A track that will not load falls back to the archive's.
     *
     * Pages serves its SPA fallback for an unknown path, so a missing mp3
     * arrives as a 200 of HTML rather than a 404 — the element fails, and
     * without this the volumes would simply be silent with nothing to say why.
     */
    element.addEventListener('error', () => {
      if (track === 'archive' || current !== track) return;
      current = 'archive';
      if (wanted()) startCurrent();
    });

    themes.set(track, element);
    return element;
  } catch {
    return null;
  }
}

/** Whether the current track should be sounding at all. */
const wanted = (): boolean => music.get() && gestured && !muted.get();

function startCurrent(): void {
  const element = themeElement(current);
  if (element === null) return;
  try {
    element.preload = 'auto';
    void element.play().catch(() => {
      /* refused, or the file is not there; the archive reads the same */
    });
  } catch {
    /* as above */
  }
}

function stopAll(): void {
  for (const element of themes.values()) {
    try {
      element.pause();
    } catch {
      /* nothing to do */
    }
  }
}

/**
 * Move to another track.
 *
 * Called by the screens rather than by the toggle: opening a volume asks for
 * the reading track and closing it asks for the archive's. If the music is off
 * this only records where we are, so that turning it on later starts the right
 * one rather than whatever was playing last.
 */
export function setMusicTrack(track: Track): void {
  if (track === current) return;
  current = track;
  stopAll();
  if (wanted()) startCurrent();
}

/**
 * Start or stop the music.
 *
 * Only ever called from the header toggle, which is off by default and stays
 * off until someone asks for it. The brief rules out an ambient track that
 * starts on its own, and this does not: the preference is remembered, so a
 * visitor who turned it on last time gets it back on their next gesture, and a
 * visitor who never asks never hears it.
 */
export function setMusic(on: boolean): void {
  music.set(on);
  if (on && gestured && !muted.get()) startCurrent();
  else stopAll();
}

export function setMuted(on: boolean): void {
  muted.set(on);
  if (on) stopAll();
  else if (music.get()) startCurrent();
}

/* -- the gesture ---------------------------------------------------------- */

/**
 * Arm the sound layer on the visitor's first interaction.
 *
 * Registered once, from main. Until this fires, `audio()` returns null and
 * every cue is a no-op, so there is no path by which the archive makes a sound
 * at someone who has not touched it.
 */
export function armOnFirstGesture(): void {
  if (gestured) return;
  const arm = (): void => {
    if (gestured) return;
    gestured = true;
    window.removeEventListener('pointerdown', arm, true);
    window.removeEventListener('keydown', arm, true);
    // A visitor who left the music on last time gets it back now that they
    // have given the page the gesture a browser requires.
    if (wanted()) startCurrent();
  };
  // CAPTURE PHASE, and it matters. The gesture that arms the sound layer is
  // usually the same gesture that asks for the first cue — clicking the gate
  // both permits audio and wants the unlock to sound. On the bubble phase this
  // listener runs after the gate's own handler, `gestured` is still false when
  // play() is reached, and the first sound the archive ever makes is silence.
  window.addEventListener('pointerdown', arm, { passive: true, capture: true });
  window.addEventListener('keydown', arm, true);
}
