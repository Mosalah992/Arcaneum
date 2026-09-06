/**
 * The boot sequence. A disc spinning up, once.
 *
 * Driven by plain timers rather than by a tween. Two reasons: a DOS progress
 * bar advances in whole cells and should look stepped, and nothing here may
 * depend on the frame loop — a boot screen that hangs because the tab was
 * backgrounded is a boot screen that hangs forever, with the archive behind it.
 * `done()` is idempotent and four things can call it.
 */

import { el } from '../lib/dom';
import { navigate, type Screen } from '../lib/router';
import { visited } from '../lib/store';

/** Cells in the loading bar. */
const CELLS = 24;

/** The whole sequence, start to finish. The brief allows 2.5s. */
const TOTAL_MS = 2300;

interface Line {
  at: number;
  text: string;
  class?: string;
}

const SCRIPT: Line[] = [
  { at: 0, text: 'ARCANAEUM CD-ROM   v1.02', class: 'boot-line--head' },
  { at: 0, text: '(C) COLLEGE OF WINTERHOLD  ·  4E 201' },
  { at: 0, text: '' },
  { at: 140, text: 'DETECTING DRIVE .............. OK' },
  { at: 340, text: 'SPINNING UP .................. 4x' },
  { at: 540, text: 'READING TABLE OF CONTENTS .... 1204 SECTORS' },
  { at: 740, text: 'MOUNTING VOLUME .............. ARCANAEUM' },
  { at: 900, text: '' },
  { at: 900, text: 'LOADING ARCANAEUM.EXE', class: 'boot-line--head' },
];

const BAR_FROM = 1000;
const BAR_TO = 2150;

export function bootScreen(): Screen {
  const log = el('pre', { class: 'boot-log' });
  const bar = el('pre', { class: 'boot-bar' });
  const hint = el('p', { class: 'boot-hint' }, 'PRESS ANY KEY');

  const element = el(
    'div',
    { class: 'screen boot' },
    el('div', { class: 'boot-inner' }, log, bar, hint),
  );

  const timers: number[] = [];
  let ticker = 0;
  let finished = false;

  function done(): void {
    if (finished) return;
    finished = true;
    for (const timer of timers) window.clearTimeout(timer);
    window.clearInterval(ticker);
    window.removeEventListener('keydown', onSkip);
    element.removeEventListener('pointerdown', onSkip);
    visited.set(true);
    navigate('/chamber', true);
  }

  function onSkip(): void {
    done();
  }

  function drawBar(fraction: number): void {
    const filled = Math.round(Math.min(Math.max(fraction, 0), 1) * CELLS);
    const percent = Math.round(Math.min(Math.max(fraction, 0), 1) * 100);
    bar.textContent = `${'█'.repeat(filled)}${'░'.repeat(CELLS - filled)}  ${String(percent).padStart(3)}%`;
  }

  for (const line of SCRIPT) {
    timers.push(
      window.setTimeout(() => {
        log.append(
          el('span', { class: `boot-line${line.class ? ` ${line.class}` : ''}` }, line.text),
          document.createTextNode('\n'),
        );
      }, line.at),
    );
  }

  drawBar(0);
  timers.push(
    window.setTimeout(() => {
      const started = performance.now();
      ticker = window.setInterval(() => {
        const fraction = (performance.now() - started) / (BAR_TO - BAR_FROM);
        drawBar(fraction);
        if (fraction >= 1) window.clearInterval(ticker);
      }, 40);
    }, BAR_FROM),
  );

  // The backstop. Even with every timer above throttled or dropped, the disc
  // finishes spinning up and the archive opens.
  timers.push(window.setTimeout(done, TOTAL_MS));

  window.addEventListener('keydown', onSkip);
  element.addEventListener('pointerdown', onSkip);

  return {
    element,
    title: 'BOOT',
    chrome: false,
    destroy() {
      finished = true;
      for (const timer of timers) window.clearTimeout(timer);
      window.clearInterval(ticker);
      window.removeEventListener('keydown', onSkip);
    },
  };
}
