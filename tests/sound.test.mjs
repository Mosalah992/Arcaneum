import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { runInNewContext } from 'node:vm';
import ts from 'typescript';

const compile = (path) => ts.transpileModule(
  readFileSync(new URL(path, import.meta.url), 'utf8'),
  { compilerOptions: { module: ts.ModuleKind.CommonJS, target: ts.ScriptTarget.ES2022 } },
).outputText;
const storeCode = compile('../src/lib/store.ts');
const soundCode = compile('../src/lib/sound.ts');

function setup({ unavailable = false, refuses = false } = {}) {
  const values = new Map();
  const events = new EventTarget();
  let contexts = 0;
  let starts = 0;
  const parameter = () => ({
    value: 0,
    setValueAtTime() {},
    linearRampToValueAtTime() {},
    exponentialRampToValueAtTime() {},
  });
  class AudioContext {
    currentTime = 0;
    sampleRate = 44100;
    destination = {};
    constructor() {
      contexts++;
      if (refuses) throw new Error('Audio unavailable');
    }
    createGain() { return { gain: parameter(), connect() {} }; }
    createOscillator() {
      return { frequency: parameter(), connect() {}, start() { starts++; }, stop() {} };
    }
  }
  const store = {};
  runInNewContext(storeCode, {
    exports: store,
    localStorage: {
      getItem: (key) => values.get(key) ?? null,
      setItem: (key, value) => values.set(key, value),
    },
  });
  const sound = {};
  runInNewContext(soundCode, {
    exports: sound,
    require: (name) => { assert.equal(name, './store'); return store; },
    window: {
      AudioContext: unavailable ? undefined : AudioContext,
      addEventListener: events.addEventListener.bind(events),
      removeEventListener: events.removeEventListener.bind(events),
    },
  });
  return { sound, store, events, contexts: () => contexts, starts: () => starts };
}

for (const gesture of ['pointerdown', 'keydown']) {
  test(`first ${gesture} arms cues without invoking removed music helpers`, () => {
    const app = setup();
    app.sound.armOnFirstGesture();
    app.sound.play('tick');
    assert.equal(app.contexts(), 0, 'no audio context before a gesture');
    app.events.dispatchEvent(new Event(gesture));
    app.sound.play('tick');
    assert.equal(app.contexts(), 1);
    assert.equal(app.starts(), 1, 'cue plays after admission of the gesture');
  });
}

test('SOUND toggle persists mute, suppresses cues, and enables them again', () => {
  const app = setup();
  app.sound.armOnFirstGesture();
  app.events.dispatchEvent(new Event('pointerdown'));
  app.sound.setMuted(true);
  assert.equal(app.store.muted.get(), true);
  app.sound.play('tick');
  assert.equal(app.contexts(), 0);
  app.sound.setMuted(false);
  assert.equal(app.store.muted.get(), false);
  app.sound.play('tick');
  assert.equal(app.starts(), 1);
  app.sound.setMuted(true);
  app.sound.play('tick');
  assert.equal(app.starts(), 1, 'muting also suppresses cues with an existing context');
});

for (const options of [{ unavailable: true }, { refuses: true }]) {
  test(`unavailable Web Audio degrades silently: ${JSON.stringify(options)}`, () => {
    const app = setup(options);
    app.sound.armOnFirstGesture();
    app.events.dispatchEvent(new Event('keydown'));
    assert.doesNotThrow(() => app.sound.play('tick'));
    assert.equal(app.starts(), 0);
  });
}
