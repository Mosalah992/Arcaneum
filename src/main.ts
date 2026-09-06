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
import './styles/catalogue.css';
import './styles/reader.css';

import { el } from './lib/dom';
import { createRouter, navigate, type Screen } from './lib/router';
import { scanlines, muted, forgetDiscoveries } from './lib/store';
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
  // Wired to the sound layer in a later step; the preference is kept from now
  // so that a visitor who mutes never hears the archive at all.
  toggleButton('SOUND', !muted.get(), (on) => muted.set(!on)),
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

createRouter(
  stage,
  {
    '/': () => catalogueScreen(),
    '/catalogue': () => catalogueScreen(),
    '/tome/:id': (params) => readerScreen(params),
  },
  () => catalogueScreen(),
  (screen: Screen) => {
    crumb.textContent = screen.title ? `· ${screen.title}` : '';
  },
);
