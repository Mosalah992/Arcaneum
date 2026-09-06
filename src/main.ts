/**
 * The Arcanaeum.
 *
 * Everything outside the chamber is plain DOM and CSS. This module builds the
 * stone frame — header, stage, footer — and hands the stage to the router.
 */

// Self-hosted, latin subsets only. Nothing is fetched from a font CDN.
import '@fontsource/vt323/latin-400.css';
import '@fontsource/eb-garamond/latin-400.css';
import '@fontsource/eb-garamond/latin-400-italic.css';
import '@fontsource/eb-garamond/latin-600.css';

import './styles/tokens.css';
import './styles/base.css';
import './styles/chrome.css';
import './styles/boot.css';
import './styles/chamber.css';
import './styles/catalogue.css';
import './styles/reader.css';

import { el, prefersReducedMotion } from './lib/dom';
import { createRouter, currentPath, navigate, type Screen } from './lib/router';
import { scanlines, muted, music, visited, forgetDiscoveries } from './lib/store';
import { armOnFirstGesture, setMusic, setMuted } from './lib/sound';
import { bootScreen } from './screens/boot';
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
  el(
    'span',
    { class: 'chrome-title' },
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

/**
 * The chamber, behind a dynamic import.
 *
 * three.js is the largest thing in the project by an order of magnitude and
 * every other screen works without it, so it is its own chunk and a visitor
 * who never enters the chamber — reduced motion, a phone, a bookmark straight
 * to the catalogue — never downloads a byte of it. If the chunk fails to
 * arrive, the archive is still an archive: go around.
 */
function chamberRoute(): Screen {
  const host = el('div', { class: 'screen' });
  let inner: Screen | null = null;
  let dropped = false;

  void import('./screens/chamber')
    .then(({ chamberScreen }) => {
      if (dropped) return;
      inner = chamberScreen();
      host.append(inner.element);
    })
    .catch(() => {
      if (!dropped) navigate('/catalogue', true);
    });

  return {
    element: host,
    title: 'THE CHAMBER',
    destroy() {
      dropped = true;
      inner?.destroy?.();
    },
  };
}

/*
 * Where a bare visit lands.
 *
 * Resolved once, before the router is built, rather than from inside a route —
 * a route that redirects re-enters the router while it is still rendering.
 */
if (currentPath() === '/') {
  const first = !visited.get();
  navigate(
    prefersReducedMotion() ? '/catalogue' : first ? '/boot' : '/chamber',
    true,
  );
}

createRouter(
  stage,
  {
    '/boot': () => bootScreen(),
    '/chamber': () => chamberRoute(),
    '/catalogue': () => catalogueScreen(),
    '/tome/:id': (params) => readerScreen(params),
  },
  () => catalogueScreen(),
  (screen: Screen) => {
    crumb.textContent = screen.title ? `· ${screen.title}` : '';
    document.documentElement.dataset.chrome = screen.chrome === false ? 'off' : 'on';
  },
);
