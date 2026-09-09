/**
 * The front door: a 3.5" disc going into a drive.
 *
 * This replaces the three.js chamber. DOM and CSS only — the disc, the slot,
 * the bevels and the shutter are elements, per the project's standing rule
 * that a bevel is a box-shadow and not a picture. Deleting the chamber took
 * three.js out of the bundle entirely.
 *
 * TIMERS, NOT TWEENS, for anything the sequence depends on. The boot screen
 * settled this already: a backgrounded tab produces no frames, and a front
 * door that never opens is worse than one that is not animated. anime.js moves
 * the disc because that is decoration; `done()` is idempotent and four things
 * can call it, so the archive opens whether or not a single frame is drawn.
 *
 * Every guarantee the chamber gave is kept: under 2.5 seconds, skippable on
 * any key, and it does not run at all under prefers-reduced-motion or on a
 * repeat visit — both of which land on the catalogue, decided in main.ts.
 */

import { animate } from 'animejs';
import { el, prefersReducedMotion } from '../lib/dom';
import { navigate, type Screen } from '../lib/router';
import { visited } from '../lib/store';
import { play } from '../lib/sound';

/** The whole sequence, start to catalogue. The brief allowed 2.5s. */
const TOTAL_MS = 2400;

/** When the disc is fully in and the drive takes over. */
const SEATED_MS = 1100;

interface Beat {
  at: number;
  text: string;
  head?: boolean;
}

const SCRIPT: Beat[] = [
  { at: SEATED_MS + 40, text: 'DRIVE A: DISC PRESENT', head: true },
  { at: SEATED_MS + 220, text: 'READING BOOT SECTOR ......... OK' },
  { at: SEATED_MS + 430, text: 'VOLUME LABEL ................ ARCANAEUM' },
  { at: SEATED_MS + 640, text: 'CATALOGUING ................. 249 VOLUMES' },
  { at: SEATED_MS + 850, text: '' },
  { at: SEATED_MS + 880, text: 'STARTING ARCANAEUM.EXE', head: true },
];

export function insertScreen(): Screen {
  const sigil = el('div', { class: 'disc__sigil', 'aria-hidden': 'true' });

  const disc = el(
    'div',
    { class: 'disc', 'aria-hidden': 'true' },
    el('div', { class: 'disc__shutter' }),
    el('div', { class: 'disc__notch' }),
    el('div', { class: 'disc__label' }, sigil),
  );

  const drive = el(
    'div',
    { class: 'drive', 'aria-hidden': 'true' },
    el('div', { class: 'drive__slot' }),
    el('div', { class: 'drive__lip' }),
    el('div', { class: 'drive__led' }),
  );

  const log = el('pre', { class: 'insert-log' });
  const hint = el('p', { class: 'insert-hint' }, 'PRESS ANY KEY');

  const element = el(
    'div',
    { class: 'screen insert' },
    el(
      'div',
      { class: 'insert-inner' },
      el('div', { class: 'insert-bay' }, disc, drive),
      log,
      hint,
    ),
  );

  const timers: number[] = [];
  let finished = false;

  function done(): void {
    if (finished) return;
    finished = true;
    for (const timer of timers) window.clearTimeout(timer);
    window.removeEventListener('keydown', onSkip);
    element.removeEventListener('pointerdown', onSkip);
    visited.set(true);
    navigate('/catalogue', true);
  }

  function onSkip(): void {
    done();
  }

  for (const beat of SCRIPT) {
    timers.push(
      window.setTimeout(() => {
        log.append(
          el('span', { class: `insert-line${beat.head === true ? ' insert-line--head' : ''}` }, beat.text),
          document.createTextNode('\n'),
        );
      }, beat.at),
    );
  }

  // The drive takes the disc: the shutter opens, the light comes on, and the
  // grind is the same cue the gate used to make.
  timers.push(
    window.setTimeout(() => {
      element.classList.add('insert--seated');
      play('grind');
    }, SEATED_MS),
  );

  // The backstop. Even with every timer above throttled and no frame ever
  // drawn, the disc finishes loading and the archive opens.
  timers.push(window.setTimeout(done, TOTAL_MS));

  window.addEventListener('keydown', onSkip);
  element.addEventListener('pointerdown', onSkip);

  // Decoration, and only decoration. Nothing below is awaited or depended on.
  if (!prefersReducedMotion()) {
    animate(disc, {
      translateY: ['-118%', '0%'],
      rotate: ['-2.5deg', '0deg'],
      duration: SEATED_MS,
      ease: 'cubicBezier(0.32, 0.9, 0.28, 1)',
    });
  }

  return {
    element,
    title: 'INSERT DISC',
    chrome: false,
    destroy() {
      finished = true;
      for (const timer of timers) window.clearTimeout(timer);
      window.removeEventListener('keydown', onSkip);
    },
  };
}
