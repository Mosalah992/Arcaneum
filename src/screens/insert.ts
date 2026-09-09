/**
 * The front door: a 3.5" disc, and a drive to put it in.
 *
 * This replaces the three.js chamber, which took three.js out of the bundle
 * entirely. The disc is the supplied painting; the drive around it is CSS, per
 * the project's standing rule that a bevel is a box-shadow and not a picture.
 *
 * THE VISITOR INSERTS IT. Nothing happens until the disc goes in, and putting
 * it in is the affordance — the same idea the chamber's gate had, where there
 * was no ENTER button and the light was the invitation. The disc sits proud of
 * the slot, the cursor changes over it and over the drive, and clicking either
 * one seats it. Then the drive reads, and the archive opens.
 *
 * TIMERS, NOT TWEENS, for everything after that. A backgrounded tab produces no
 * frames, and a door that has been opened and then never finishes opening is
 * worse than one that was never animated. anime.js moves the disc because that
 * is decoration; `done()` is idempotent and three things can call it, so once
 * the disc is in, the archive opens whether or not another frame is drawn.
 *
 * Reduced motion and repeat visits never reach this screen at all — main.ts
 * sends both straight to the catalogue.
 */

import { animate } from 'animejs';
import { el, prefersReducedMotion } from '../lib/dom';
import { navigate, type Screen } from '../lib/router';
import { visited } from '../lib/store';
import { play } from '../lib/sound';

/** How long the disc takes to go in. */
const SEAT_MS = 620;

/** From the disc seating to the catalogue. The brief allowed 2.5s. */
const READ_MS = 1500;

interface Beat {
  at: number;
  text: string;
  head?: boolean;
}

const SCRIPT: Beat[] = [
  { at: 40, text: 'DRIVE A: DISC PRESENT', head: true },
  { at: 250, text: 'READING BOOT SECTOR ......... OK' },
  { at: 470, text: 'VOLUME LABEL ................ ARCANAEUM' },
  { at: 700, text: 'CATALOGUING ................. 249 VOLUMES' },
  { at: 930, text: '' },
  { at: 960, text: 'STARTING ARCANAEUM.EXE', head: true },
];

export function insertScreen(): Screen {
  const disc = el('div', {
    class: 'disc',
    role: 'button',
    tabindex: '0',
    'aria-label': 'Insert the disc',
  });

  const drive = el(
    'div',
    { class: 'drive' },
    el('div', { class: 'drive__slot' }),
    el('div', { class: 'drive__lip' }),
    el('div', { class: 'drive__led' }),
  );

  const bay = el('div', { class: 'insert-bay' }, disc, drive);
  const log = el('pre', { class: 'insert-log' });
  const hint = el('p', { class: 'insert-hint' }, 'INSERT THE DISC');

  const element = el(
    'div',
    { class: 'screen insert' },
    el('div', { class: 'insert-inner' }, bay, log, hint),
  );

  const timers: number[] = [];
  let started = false;
  let finished = false;

  function done(): void {
    if (finished) return;
    finished = true;
    for (const timer of timers) window.clearTimeout(timer);
    window.removeEventListener('keydown', onKeydown);
    visited.set(true);
    navigate('/catalogue', true);
  }

  /** Put the disc in. Everything after this is on a timer. */
  function begin(): void {
    if (started || finished) return;
    started = true;

    element.classList.add('insert--seated');
    disc.removeAttribute('tabindex');
    disc.setAttribute('aria-hidden', 'true');
    hint.textContent = 'PRESS ANY KEY';
    play('grind');

    for (const beat of SCRIPT) {
      timers.push(
        window.setTimeout(() => {
          log.append(
            el(
              'span',
              { class: `insert-line${beat.head === true ? ' insert-line--head' : ''}` },
              beat.text,
            ),
            document.createTextNode('\n'),
          );
        }, SEAT_MS + beat.at),
      );
    }

    // The backstop. Even with every timer above throttled and no frame ever
    // drawn, the drive finishes reading and the archive opens.
    timers.push(window.setTimeout(done, SEAT_MS + READ_MS));

    // Decoration, and only decoration. Nothing is awaited or depended on.
    if (!prefersReducedMotion()) {
      animate(disc, {
        translateY: ['0%', '46%'],
        scale: [1, 0.94],
        duration: SEAT_MS,
        ease: 'cubicBezier(0.34, 0.86, 0.3, 1)',
      });
    }
  }

  /**
   * A key does whichever thing is next: puts the disc in, or waves the drive
   * through. Never nothing — somebody pressing keys at a door expects it to
   * answer, and this one has exactly two states.
   */
  function onKeydown(event: KeyboardEvent): void {
    if (event.metaKey || event.ctrlKey || event.altKey) return;
    if (!started) {
      event.preventDefault();
      begin();
      return;
    }
    done();
  }

  // The disc and the drive are both the target: a visitor reaches for whichever
  // reads as the thing to click, and being wrong about which should cost
  // nothing.
  disc.addEventListener('click', begin);
  drive.addEventListener('click', begin);
  window.addEventListener('keydown', onKeydown);

  return {
    element,
    title: 'INSERT DISC',
    chrome: false,
    destroy() {
      finished = true;
      for (const timer of timers) window.clearTimeout(timer);
      window.removeEventListener('keydown', onKeydown);
    },
  };
}
