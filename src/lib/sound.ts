/**
 * The sound layer.
 *
 * The four cues — hover tick, page turn, stone grind, gate unlock — are
 * synthesised in Web Audio rather than loaded.
 *
 * NOTHING PLAYS UNTIL A GESTURE. The AudioContext is not constructed until
 * the visitor has interacted with the page.
 *
 * EVERY PATH IS OPTIONAL. Web Audio missing, the context refusing to start,
 * a cue failing to play — each is caught and dropped. Silence is a
 * degraded archive, not a broken one.
 */

import { muted } from './store';

export type Cue = 'tick' | 'page' | 'grind' | 'unlock';

let ctx: AudioContext | null = null;
let master: GainNode | null = null;
let noise: AudioBuffer | null = null;
let gestured = false;

/** Persist the preference used by every cue and the header SOUND toggle. */
export function setMuted(on: boolean): void {
  muted.set(on);
}

/** White noise, made once and reused by the paper and stone cues. */
function noiseBuffer(context: AudioContext): AudioBuffer {
  if (noise !== null) return noise;

  const length = Math.floor(context.sampleRate * 1.2);
  const buffer = context.createBuffer(1, length, context.sampleRate);
  const data = buffer.getChannelData(0);

  for (let i = 0; i < length; i++) {
    data[i] = Math.random() * 2 - 1;
  }

  noise = buffer;
  return buffer;
}

function audio(): AudioContext | null {
  if (!gestured) return null;
  if (ctx !== null) return ctx;

  try {
    const Ctor =
      window.AudioContext ??
      (window as unknown as {
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

  if (to !== from) {
    osc.frequency.exponentialRampToValueAtTime(to, at + length);
  }

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
        blip(context, master, 'square', 1750, 1750, at, 0.028, 0.055);
        break;

      case 'page':
        rush(context, master, at, 0.24, 0.12, 'bandpass', 2600, 700);
        break;

      case 'grind':
        rush(context, master, at, 0.85, 0.19, 'lowpass', 900, 160);
        blip(context, master, 'sawtooth', 74, 52, at, 0.8, 0.1);
        blip(context, master, 'sawtooth', 71, 49, at + 0.02, 0.78, 0.08);
        break;

      case 'unlock':
        blip(context, master, 'square', 392, 392, at, 0.1, 0.09);
        blip(context, master, 'square', 523, 523, at + 0.09, 0.1, 0.09);
        blip(context, master, 'square', 659, 659, at + 0.18, 0.12, 0.09);
        blip(context, master, 'triangle', 1046, 1568, at + 0.28, 0.5, 0.07);
        break;
    }
  } catch {
    /* A cue that will not sound is not worth an error. */
  }
}

/* -- the gesture ---------------------------------------------------------- */

/**
 * Arm the sound layer on the visitor's first interaction.
 *
 * Registered once from main. Until this fires, audio() returns null and
 * every cue is a no-op.
 */
export function armOnFirstGesture(): void {
  if (gestured) return;

  const arm = (): void => {
    if (gestured) return;

    gestured = true;

    window.removeEventListener('pointerdown', arm, true);
    window.removeEventListener('keydown', arm, true);
  };

  window.addEventListener('pointerdown', arm, {
    passive: true,
    capture: true,
  });

  window.addEventListener('keydown', arm, true);
}
