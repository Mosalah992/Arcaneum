import test from 'node:test';
import assert from 'node:assert/strict';
import { normalizeVolumeLabel } from '../scripts/volume-normalize.mjs';

test('normalizeVolumeLabel canonicalizes review examples to a single Volume N label', () => {
  assert.equal(normalizeVolumeLabel('Songs of the Return, Volume 2, The First Tale of the Darumzu'), 'Volume 2');
  assert.equal(normalizeVolumeLabel('2920, Morning Star, Book 1'), 'Volume 1');
  assert.equal(normalizeVolumeLabel('The Lusty Argonian Maid') || '', '');
});
