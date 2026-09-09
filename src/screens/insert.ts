/**
 * The front door, and it is the front door every time.
 *
 * A workstation of the right vintage on a stone desk, its monitor framing the
 * archive's own screen, and a 3.5" disc waiting on the stone in front of it. This is not a
 * one-off entrance any more: every visit starts here, the disc goes in, and
 * the catalogue opens. The `visited` flag that used to skip it after the first
 * time is gone from the project entirely.
 *
 * THE VISITOR INSERTS IT. Nothing happens until the disc goes in, and putting
 * it in is the affordance — the same idea the old chamber's gate had, where
 * there was no ENTER button and the light was the invitation. The disc sits on
 * the desk, lifts when it is reached for, and clicking it (or the machine, or
 * any key) drives it up into the slot. Then the drive reads, and the archive
 * opens.
 *
 * TIMERS, NOT TWEENS, for everything after that. A backgrounded tab produces no
 * frames, and a door that has been opened and then never finishes opening is
 * worse than one that was never animated. anime.js moves the disc because that
 * is decoration; `done()` is idempotent and three things can call it, so once
 * the disc is in, the archive opens whether or not another frame is drawn.
 *
 * Reduced motion gets the same screen and the same disc — it is the way in, so
 * it cannot be skipped — with the travel taken out of it.
 */

import { animate, cubicBezier } from 'animejs';
import { el, prefersReducedMotion } from '../lib/dom';
import { navigate, type Screen } from '../lib/router';
import { play } from '../lib/sound';

/** How long the disc takes to go in. */
const SEAT_MS = 700;

/** From the disc seating to the catalogue. The brief allowed 2.5s. */
const READ_MS = 1500;

/**
 * How far the disc travels, as a share of its own height.
 *
 * Enough to carry its bottom edge past the slot, which is where `.disc-track`
 * clips: at rest the disc stands about 107% of its own height below the cut, so
 * this is a little past the distance at which the last of it disappears into
 * the machine. Change the slot's position in insert.css and this changes
 * with it.
 */
const TRAVEL = '-120%';

/**
 * The disc going in: slow to leave the desk, then taken.
 *
 * Built as a function, not written as a string. Anime 4.5 removed the string
 * form of `cubicBezier(...)` from the core, and what it does instead is worse
 * than throwing — the tween is created, its first frame is written, and it
 * never advances. The disc sat on the desk at `translateY(0%)` through the
 * whole sequence with nothing in the console to say why, and because the
 * archive opens on a timer rather than on the tween, it opened anyway and the
 * only symptom was a disc that never moved. The reader carries a note about
 * the same trap on its page turn.
 */
const SEATING = cubicBezier(0.36, 0.06, 0.2, 1);

interface Beat {
  at: number;
  text: string;
  head?: boolean;
}

const SCRIPT: Beat[] = [
  { at: 40, text: 'DRIVE A: DISC PRESENT', head: true },
  { at: 250, text: 'READING BOOT SECTOR ....... OK' },
  { at: 470, text: 'VOLUME LABEL ...... ARCANAEUM' },
  { at: 700, text: 'CATALOGUING ....... 249 VOLUMES' },
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

  const log = el('pre', { class: 'crt__log' });
  const hint = el('p', { class: 'crt__hint' }, 'INSERT THE DISC');

  const crt = el(
    'div',
    { class: 'crt' },
    el('div', { class: 'crt__scrim', 'aria-hidden': 'true' }),
    el('div', { class: 'crt__edge', 'aria-hidden': 'true' }),
    el(
      'div',
      { class: 'crt__inner' },
      el(
        'div',
        { class: 'crt__head' },
        el('span', { class: 'crt__mark' }, '❖'),
        ' THE ARCANAEUM',
      ),
      el('div', { class: 'crt__sub' }, 'COLLEGE OF WINTERHOLD'),
      log,
      hint,
    ),
  );

  // The disc's own layer. It is clipped along the top edge of the drive slot,
  // so the disc is drawn in front of the machine on its way in and simply
  // stops existing at the moment it crosses into it — which is the whole
  // insertion, done with a clip rather than with a second copy of the plate.
  const track = el('div', { class: 'disc-track' }, disc);

  const slot = el('div', { class: 'rig__slot', 'aria-hidden': 'true' });
  const led = el('div', { class: 'rig__led', 'aria-hidden': 'true' });
  // The tower's own lamp, painted amber on the plate. It goes green when the
  // machine has something to read — see `.rig__lamp` in insert.css.
  const lamp = el('div', { class: 'rig__lamp', 'aria-hidden': 'true' });

  const rig = el('div', { class: 'rig' }, crt, slot, led, lamp, track);

  const element = el(
    'div',
    { class: 'screen insert' },
    // Painted before the machine, so the machine's shadow lands on it.
    el('div', { class: 'desk', 'aria-hidden': 'true' }),
    rig,
  );

  const timers: number[] = [];
  let started = false;
  let finished = false;

  function done(): void {
    if (finished) return;
    finished = true;
    for (const timer of timers) window.clearTimeout(timer);
    window.removeEventListener('keydown', onKeydown);
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
              { class: `crt__line${beat.head === true ? ' crt__line--head' : ''}` },
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
    if (prefersReducedMotion()) {
      disc.style.visibility = 'hidden';
      return;
    }
    animate(disc, {
      translateY: ['0%', TRAVEL],
      // A shade smaller on the way in, which is all the foreshortening a flat
      // elevation can honestly claim.
      scale: [1, 0.88],
      duration: SEAT_MS,
      ease: SEATING,
    });
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

  // The disc and the machine are both the target: a visitor reaches for
  // whichever reads as the thing to click, and being wrong about which should
  // cost nothing.
  disc.addEventListener('click', begin);
  rig.addEventListener('click', begin);
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
