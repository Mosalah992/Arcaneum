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
import './styles/reader.css';

import { el, prefersReducedMotion } from './lib/dom';
import { createRouter, currentPath, navigate, type Screen } from './lib/router';
import { scanlines, muted, music, visited, forgetDiscoveries } from './lib/store';
import { armOnFirstGesture, setMusic, setMuted } from './lib/sound';
import { insertScreen } from './screens/insert';
import { catalogueScreen } from './screens/catalogue';
import { readerScreen } from './screens/reader';

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

/** Decorative. There is no counter behind this and there will not be one. */
const hitCounter = el(
  'span',
  { class: 'hit-counter', title: 'decorative' },
  ...'0041982'.split('').map((digit) => el('b', {}, digit)),
);

const footer = el(
  'footer',
  { class: 'chrome-bar chrome-bar--footer' },
  el('span', { class: 'footer-note' }, 'VISITORS '),
  hitCounter,
  el('span', { class: 'chrome-spacer' }),
  el(
    'span',
    { class: 'footer-note footer-note--wide' },
    'COLLEGE OF WINTERHOLD · 4E 201 · ',
  ),
  // The text is Bethesda's and the transcription is the Library of Skyrim's.
  // Credit belongs where a reader can see it, not only in PROVENANCE.md.
  el(
    'span',
    { class: 'footer-note footer-note--wide' },
    'TEXT © BETHESDA · PORTED FROM THE LIBRARY OF SKYRIM · ',
  ),
  el(
    'button',
    {
      class: 'footer-link',
      type: 'button',
      onclick: () => {
        forgetDiscoveries();
        navigate('/catalogue');
        window.location.reload();
      },
    },
    'forget my discoveries',
  ),
);

/* -- stage -------------------------------------------------------------- */

const stage = el('main', { class: 'screen', id: 'stage' });

root.append(header, stage, footer);
document.body.append(el('div', { id: 'scanlines', 'aria-hidden': 'true' }));

armOnFirstGesture();

/*
 * Where a bare visit lands.
 *
 * Two branches now rather than three: the disc goes in on a first visit and
 * never again. Resolved once, before the router is built, rather than from
 * inside a route — a route that redirects re-enters the router while it is
 * still rendering.
 */
if (currentPath() === '/') {
  const showDisc = !visited.get() && !prefersReducedMotion();
  navigate(showDisc ? '/insert' : '/catalogue', true);
}

createRouter(
  stage,
  {
    '/insert': () => insertScreen(),
    '/catalogue': () => catalogueScreen(),
    '/tome/:id': (params) => readerScreen(params),
  },
  () => catalogueScreen(),
  (screen: Screen) => {
    crumb.textContent = screen.title ? `· ${screen.title}` : '';
    document.documentElement.dataset.chrome = screen.chrome === false ? 'off' : 'on';
  },
);
