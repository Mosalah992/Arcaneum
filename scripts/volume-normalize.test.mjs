import test from 'node:test';
import assert from 'node:assert/strict';
import { normalizeVolumeFromHeading } from './volume-normalize.mjs';

test('normalizes body and title headings into canonical Volume labels', () => {
  assert.equal(normalizeVolumeFromHeading('## Songs of the Return, Volume 2, The First Tale of the Darumzu'), 'Volume 2');
  assert.equal(normalizeVolumeFromHeading('## 2920, Morning Star, Book 1'), 'Volume 1');
  assert.equal(normalizeVolumeFromHeading('## Part I: The Ransom of Zarek'), 'Volume 1');
  assert.equal(normalizeVolumeFromHeading('## Chapter 4'), 'Volume 4');
  assert.equal(normalizeVolumeFromHeading('## Volume 1'), 'Volume 1');
  assert.equal(normalizeVolumeFromHeading('## Book One'), 'Volume 1');
  assert.equal(normalizeVolumeFromHeading('## Book Eight'), 'Volume 8');
  assert.equal(normalizeVolumeFromHeading('## Book Twenty-One'), 'Volume 21');
});
