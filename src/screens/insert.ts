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
 *
 * AND THEN THE DRIVE ASKS FOR THE WORD. The disc going in is the visitor's
 * half; the College's half is a passphrase, typed on the monitor. A reader
 * who already holds a writ — one week, one cookie — is not asked again and
 * goes straight through, so the prompt is for a first evening rather than
 * every visit.
 *
 * THIS SCREEN IS NOT THE LOCK. The lock is `functions/api/_middleware.ts`,
 * which refuses every `/api/*` request without a writ whatever the browser
 * believes. Everything here can be edited, skipped or deleted by anyone who
 * cares to, and all it buys them is an empty catalogue.
 */

import { animate, cubicBezier } from 'animejs';
import { gateStatus, openGate } from '../lib/api';
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

/*
 * Four lines and no more.
 *
 * It used to close on a blank line and `STARTING ARCANAEUM.EXE`, which was
 * true when the disc going in was the whole of the way in. There is a door
 * after the drive now: nothing starts until the word is given, so the program
 * does not announce itself here — it announces itself in `offer()`, after the
 * word is good. Four lines is also what fits above the prompt on the glass;
 * six ran under the field.
 *
 * The count is the number of files in content/library/ and has to be kept in
 * step with them by hand. It is scenery, and a boot screen that lied about how
 * many volumes it had catalogued would still be a lie.
 */
const SCRIPT: Beat[] = [
  { at: 40, text: 'DRIVE A: DISC PRESENT', head: true },
  { at: 250, text: 'READING BOOT SECTOR ....... OK' },
  { at: 470, text: 'VOLUME LABEL ...... ARCANAEUM' },
  { at: 700, text: 'CATALOGUING ....... 250 VOLUMES' },
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

  /*
   * The word.
   *
   * A real `password` input rather than a drawn one: it is a shared word the
   * College hands out, so a browser offering to remember it is a kindness
   * rather than a hazard, and `autocomplete` is what makes that offer.
   */
  const word = el('input', {
    class: 'crt__word',
    // `id` AND `name`. The label beside it carries `for="passphrase"`, which
    // resolves against an id and not a name — so until this was added the
    // label pointed at nothing: clicking THE WORD: did not focus the field,
    // and only the `aria-label` was holding the accessible name up.
    id: 'passphrase',
    name: 'passphrase',
    type: 'password',
    autocomplete: 'current-password',
    spellcheck: 'false',
    'aria-label': 'Passphrase',
    placeholder: '█',
  });

  const refusal = el('p', { class: 'crt__refusal', role: 'status' });

  const prompt = el(
    'form',
    { class: 'crt__prompt', hidden: 'hidden' },
    el('label', { class: 'crt__ask', for: 'passphrase' }, 'THE WORD:'),
    word,
  );

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
      prompt,
      refusal,
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
  /** True once the drive has read the disc and the word has been asked for. */
  let asking = false;

  /*
   * The door's answer, fetched the moment the screen opens.
   *
   * Started here rather than when the disc goes in, so that by the time the
   * boot log has finished printing the answer is almost always already in
   * hand and a reader who holds a writ is not made to watch a spinner. If it
   * has not landed, `admit()` awaits it — the archive opens either way.
   */
  const door = gateStatus();

  function enter(): void {
    if (finished) return;
    finished = true;
    for (const timer of timers) window.clearTimeout(timer);
    window.removeEventListener('keydown', onKeydown);
    navigate('/catalogue', true);
  }

  /** Print one line on the screen, in the boot log's own hand. */
  function say(text: string, head = false): void {
    log.append(
      el('span', { class: `crt__line${head ? ' crt__line--head' : ''}` }, text),
      document.createTextNode('\n'),
    );
  }

  /**
   * The drive has read the disc. Now the College's half.
   *
   * Three ways this ends: the reader already holds a writ and goes straight
   * through; no passphrase is configured at all, which is a broken deployment
   * and says so rather than pretending to be a locked one; or the word is
   * asked for.
   */
  async function admit(): Promise<void> {
    if (finished) return;
    const gate = await door;

    if (gate.open) {
      enter();
      return;
    }

    if (!gate.configured) {
      say('', false);
      say('THE ARCHIVE IS SEALED PENDING', true);
      say('THE WARDEN’S KEY.', true);
      hint.textContent = 'NO WORD IS SET';
      return;
    }

    asking = true;
    prompt.hidden = false;
    hint.textContent = 'ENTER TO OPEN';
    word.focus();
  }

  /** Put the disc in. Everything after this is on a timer. */
  function begin(): void {
    if (started || finished) return;
    started = true;

    element.classList.add('insert--seated');
    disc.removeAttribute('tabindex');
    disc.setAttribute('aria-hidden', 'true');
    hint.textContent = 'READING';
    play('grind');

    for (const beat of SCRIPT) {
      timers.push(window.setTimeout(() => say(beat.text, beat.head === true), SEAT_MS + beat.at));
    }

    // The backstop. Even with every timer above throttled and no frame ever
    // drawn, the drive finishes reading and the door is answered.
    timers.push(window.setTimeout(() => void admit(), SEAT_MS + READ_MS));

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

  /** The word, offered. */
  async function offer(event: Event): Promise<void> {
    event.preventDefault();
    const typed = word.value;
    if (typed.trim() === '') return;

    prompt.classList.add('crt__prompt--waiting');
    word.disabled = true;
    refusal.textContent = '';

    const answer = await openGate(typed);

    prompt.classList.remove('crt__prompt--waiting');
    word.disabled = false;

    if (answer.open) {
      say('STARTING ARCANAEUM.EXE', true);
      play('unlock');
      // A beat to read it by. `enter()` is idempotent and the screen's
      // `destroy` clears the timer, so leaving early cannot strand anything.
      timers.push(window.setTimeout(enter, 700));
      return;
    }

    // The field is cleared rather than left to be corrected. A refused
    // passphrase is almost never one typo away from the right one — it is the
    // wrong word — and leaving it in place invites a reader to shuffle letters
    // around a word that was never going to work.
    word.value = '';
    refusal.textContent = answer.message ?? 'THAT IS NOT THE WORD.';
    word.focus();
  }

  prompt.addEventListener('submit', (event) => void offer(event));

  /*
   * Enter, handled on the field itself.
   *
   * A form with no submit button is supposed to submit implicitly when it has
   * exactly one text field, and this one does not — pressing Enter typed a
   * word and then sat there. Rather than add a button the screen has no room
   * for and the design does not want (the glass says ENTER TO OPEN), the key
   * is taken here, which cannot depend on a browser's reading of implicit
   * submission.
   */
  word.addEventListener('keydown', (event) => {
    if (event.key !== 'Enter') return;
    void offer(event);
  });

  /**
   * A key puts the disc in. It used to also wave the drive through once the
   * disc was seated; there is a door behind the drive now, and hurrying past
   * it is not something a keystroke can do.
   */
  function onKeydown(event: KeyboardEvent): void {
    if (event.metaKey || event.ctrlKey || event.altKey) return;
    // Once the word has been asked for, every key belongs to the field.
    if (asking) return;
    if (!started) {
      event.preventDefault();
      begin();
    }
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
