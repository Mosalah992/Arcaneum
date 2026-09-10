/**
 * The Arcanaeum.
 *
 * Plain DOM and CSS throughout — there is no longer any 3D anywhere in the
 * project. This module builds the stone frame (header, stage, footer) and
 * hands the stage to the router.
 */

// Self-hosted, latin subsets only. Nothing is fetched from a font CDN.
import '@fontsource/vt323/latin-400.css';
import '@fontsource/eb-garamond/latin-400.css';
import '@fontsource/eb-garamond/latin-400-italic.css';
import '@fontsource/eb-garamond/latin-600.css';

import './styles/tokens.css';
import './styles/base.css';
import './styles/chrome.css';
import './styles/insert.css';
import './styles/catalogue.css';

import { el } from './lib/dom';
import { createRouter, currentPath, navigate, type Screen } from './lib/router';
import { enterRegister, fetchRegister } from './lib/api';
import { formatDate, formatHour, machineTime, reckon } from '../shared/reckoning';
import { scanlines, muted, music } from './lib/store';
import { armOnFirstGesture, setMusic, setMuted } from './lib/sound';
import { insertScreen } from './screens/insert';
import { catalogueScreen } from './screens/catalogue';

const root = document.querySelector<HTMLDivElement>('#app')!;

/* -- header ------------------------------------------------------------- */

const crumb = el('span', { class: 'chrome-crumb' });

function toggleButton(
  label: string,
  pressed: boolean,
  onchange: (next: boolean) => void,
): HTMLButtonElement {
  const button = el(
    'button',
    { class: 'toggle', type: 'button', 'aria-pressed': String(pressed) },
    label,
  );
  button.addEventListener('click', () => {
    const next = button.getAttribute('aria-pressed') !== 'true';
    button.setAttribute('aria-pressed', String(next));
    onchange(next);
  });
  return button;
}

function applyScanlines(on: boolean): void {
  document.documentElement.dataset.scanlines = on ? 'on' : 'off';
}

applyScanlines(scanlines.get());

const header = el(
  'header',
  { class: 'chrome-bar chrome-bar--header' },
  // A real anchor, not a button with a click handler: hash routing means the
  // browser does the navigation itself, so middle-click and open-in-new-tab
  // behave the way the reader expects them to.
  el(
    'a',
    { class: 'chrome-title', href: '#/catalogue' },
    el('span', { class: 'sigil' }, '❖'),
    ' THE ARCANAEUM',
  ),
  crumb,
  el('span', { class: 'chrome-spacer' }),
  toggleButton('SCANLINES', scanlines.get(), (on) => {
    scanlines.set(on);
    applyScanlines(on);
  }),
  // The four cues. Pressed means audible.
  toggleButton('SOUND', !muted.get(), (on) => setMuted(!on)),
  // The library theme, separately. Off until it is asked for: an ambient track
  // that starts on its own is exactly what the brief rules out.
  toggleButton('MUSIC', music.get(), (on) => setMusic(on)),
);

/* -- footer ------------------------------------------------------------- */

/*
 * The register of consultation.
 *
 * A REAL COUNT NOW. This was `0041982` in a 90s odometer, marked `decorative`
 * and documented as never going to be anything else; the College's other
 * archive has been keeping a genuine one, so this is that design with its
 * country tally taken off — one integer in D1, incremented in SQL, deduped by a
 * cookie whose value is the literal `1`.
 *
 * The odometer stays, because it is the right object for the number. It is
 * EMPTY until the count arrives and stays empty if it never does: a counter
 * that shows nought while it waits is telling the reader something false about
 * the archive, and one that falls back to a made-up figure is worse than the
 * decoration it replaced.
 */
const hitCounter = el('span', { class: 'hit-counter hit-counter--waiting' });

/** The realm's date and hour. Filled by `tick()` below, before first paint. */
const clock = el('time', { class: 'clock' });

function showVisits(count: number | null): void {
  if (count === null) return;
  hitCounter.classList.remove('hit-counter--waiting');
  hitCounter.replaceChildren(
    ...String(count)
      .padStart(7, '0')
      .split('')
      .map((digit) => el('b', {}, digit)),
  );
}

/*
 * Entered once a reader is actually through the door.
 *
 * NOT ON PAGE LOAD, which is where this used to be and where it broke the
 * moment the gate went in: `/api/register/entry` is behind the middleware like
 * every other route, the front page runs before anybody has a writ, and both
 * calls came back 401 with the odometer left empty for the whole session. The
 * console said so and nothing else did.
 *
 * Counting after admission is also the better definition of the number. It is
 * a register of consultation, and somebody who arrived at the door and did not
 * know the word has not consulted the archive.
 *
 * A 204 means this browser was already counted today, which is the common case
 * on a reload — then the count is asked for separately, because the reader
 * still wants to see it. Neither call is awaited by anything and neither can
 * throw.
 */
let counted = false;

function countOnce(): void {
  if (counted) return;
  counted = true;
  void enterRegister().then(async (entered) => {
    showVisits(entered ?? (await fetchRegister()));
  });
}

const footer = el(
  'footer',
  { class: 'chrome-bar chrome-bar--footer' },
  el('span', { class: 'footer-note' }, 'VISITORS '),
  hitCounter,
  el('span', { class: 'chrome-spacer' }),
  el('span', { class: 'footer-note footer-note--wide' }, 'COLLEGE OF WINTERHOLD · '),
  // Bethesda's text. The Library of Skyrim's transcription is credited in
  // PROVENANCE.md and in every book's `source:` frontmatter; it used to be
  // named here too and the client asked for the line back.
  el('span', { class: 'footer-note footer-note--wide' }, 'TEXT © BETHESDA · '),
  clock,
  // `forget my discoveries` stood here. It cleared a list of call numbers a
  // visitor had resolved, which the catalogue used to fold sealed volumes into
  // the shelf. Every volume is listed now, so there was nothing left for it to
  // forget — see the head of src/screens/catalogue.ts.
);

/* -- stage -------------------------------------------------------------- */

/*
 * The realm's clock, ticked once a real second.
 *
 * A REAL SECOND IS TWO IN-WORLD MINUTES, so the displayed minute changes every
 * thirty seconds and a one-second tick is the coarsest interval that never
 * shows a stale one. Reckoned from `shared/reckoning.ts`, which is the Thalmor
 * archive's module carried across whole — two archives of the same realm
 * disagreeing about the date would be worse than either being wrong.
 *
 * `setInterval` and not `requestAnimationFrame`: a backgrounded tab produces no
 * frames, and the clock should be right when it comes back rather than frozen
 * at the moment it was hidden. Timers are throttled in the background, not
 * stopped, and each tick reads the wall clock rather than counting its own.
 */
function tick(): void {
  const moment = reckon();
  clock.replaceChildren(
    el('span', { class: 'clock__date' }, formatDate(moment)),
    el('span', { class: 'clock__time' }, formatHour(moment)),
  );
  clock.setAttribute('datetime', machineTime(moment));
}

tick();
window.setInterval(tick, 1000);

const stage = el('main', { class: 'screen', id: 'stage' });

root.append(header, stage, footer);
document.body.append(el('div', { id: 'scanlines', 'aria-hidden': 'true' }));

armOnFirstGesture();

/*
 * Where a bare visit lands: the disc, every time.
 *
 * No branch left. The workstation is the archive's front page rather than a
 * first-run title card — it is where you put the disc in, and you put the disc
 * in whenever you come. Reduced motion gets the same screen with the travel
 * taken out of it rather than being sent past it, because skipping the way in
 * is not an accessibility accommodation, it is a different site.
 *
 * Resolved once here, before the router is built, rather than from inside a
 * route — a route that redirects re-enters the router while it is still
 * rendering. Anyone arriving on `#/catalogue` or a `#/tome/:id` link still
 * lands where they were sent.
 */
if (currentPath() === '/') {
  navigate('/insert', true);
}

createRouter(
  stage,
  {
    '/insert': () => insertScreen(),
    '/catalogue': () => catalogueScreen(),
  },
  () => catalogueScreen(),
  (screen: Screen) => {
    crumb.textContent = screen.title ? `· ${screen.title}` : '';
    document.documentElement.dataset.chrome = screen.chrome === false ? 'off' : 'on';
    // Any screen but the door means a writ was accepted. A reader who lands
    // straight on `#/catalogue` still holding last week's writ counts too.
    if (currentPath() !== '/insert') countOnce();
  },
);
