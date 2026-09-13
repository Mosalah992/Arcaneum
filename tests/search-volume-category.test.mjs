import test from 'node:test';
import assert from 'node:assert/strict';

function volumeCategoryFromQuery(raw) {
  const match = raw.match(/\b(?:vol(?:ume)?|book|chapter|part)\b\s*(?:[.:\-]\s*)?([ivxlcdm]+|\d+)/i);
  if (!match) return null;

  const token = match[1].trim();
  if (/^[ivxlcdm]+$/i.test(token)) {
    const roman = { I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000 };
    let total = 0;
    for (let i = 0; i < token.length; i++) {
      const here = roman[token[i].toUpperCase()] ?? 0;
      const next = roman[token[i + 1]?.toUpperCase()] ?? 0;
      total += next > here ? -here : here;
    }
    return `Volume ${total}`;
  }

  const numeric = Number(token);
  return Number.isFinite(numeric) ? `Volume ${numeric}` : null;
}

test('volumeCategoryFromQuery maps review-style search phrases into a canonical volume category', () => {
  assert.equal(volumeCategoryFromQuery('chapter 4'), 'Volume 4');
  assert.equal(volumeCategoryFromQuery('part I'), 'Volume 1');
  assert.equal(volumeCategoryFromQuery('book 1'), 'Volume 1');
});
