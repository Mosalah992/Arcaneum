const ROMAN = { I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000 };
const WORDS = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9,
  ten: 10,
  eleven: 11,
  twelve: 12,
  thirteen: 13,
  fourteen: 14,
  fifteen: 15,
  sixteen: 16,
  seventeen: 17,
  eighteen: 18,
  nineteen: 19,
  twenty: 20,
  thirty: 30,
  forty: 40,
  fifty: 50,
};

function romanValue(s) {
  let total = 0;
  for (let i = 0; i < s.length; i++) {
    const here = ROMAN[s[i]] ?? 0;
    const next = ROMAN[s[i + 1]] ?? 0;
    total += next > here ? -here : here;
  }
  return total;
}

function wordToNumber(raw = '') {
  const parts = String(raw || '').toLowerCase().trim().split(/[\s-]+/);
  if (parts.length === 1) return WORDS[parts[0]] ?? NaN;
  if (parts.length === 2) {
    const tens = WORDS[parts[0]];
    const ones = WORDS[parts[1]];
    if (tens >= 20 && tens % 10 === 0 && ones < 10) return tens + ones;
  }
  return NaN;
}

function parseVolumeNumber(raw = '') {
  const token = String(raw || '').trim();
  if (!token) return NaN;
  if (/^[ivxlcdm]+$/i.test(token)) return romanValue(token.toUpperCase());
  const numeric = Number(token);
  if (Number.isFinite(numeric)) return numeric;
  return wordToNumber(token);
}

export function normalizeVolumeFromHeading(heading = '') {
  const text = String(heading || '').trim();
  if (!text) return '';

  const cleaned = text
    .replace(/^#+\s*/, '')
    .replace(/\b(?:the)\b\s+/i, ' ')
    .trim();

  const match = cleaned.match(/\b(?:volume|vol(?:ume)?\.?|book|chapter|part)\b\s*(?:[.:\-]\s*)?([ivxlcdm]+|\d+|[a-z]+(?:[\s-][a-z]+)?)\b/i);
  if (!match) {
    const explicit = cleaned.match(/\bvolume\b\s+([ivxlcdm]+|\d+|[a-z]+(?:[\s-][a-z]+)?)\b/i);
    if (explicit) {
      const numeric = parseVolumeNumber(explicit[1]);
      return Number.isFinite(numeric) ? `Volume ${numeric}` : '';
    }
    return '';
  }

  const numeric = parseVolumeNumber(match[1]);
  if (!Number.isFinite(numeric)) return '';
  return `Volume ${numeric}`;
}

export function normalizeVolumeLabel(value = '') {
  const text = String(value || '').trim();
  if (!text) return '';

  if (/^Volume\s+\d+$/i.test(text)) return text.replace(/^volume\s+/i, 'Volume ');

  const lines = text.split(/\r?\n/).map((line) => line.trim());
  const headings = lines.filter((line) => /^##\s+/.test(line));
  const numbers = headings.flatMap((heading) => {
    const direct = normalizeVolumeFromHeading(heading);
    const n = direct.match(/\d+/)?.[0];
    return n ? [Number(n)] : [];
  });

  if (numbers.length >= 2) {
    const min = Math.min(...numbers);
    const max = Math.max(...numbers);
    return min === max ? `Volume ${min}` : `Volume ${min}-${max}`;
  }

  const direct = normalizeVolumeFromHeading(text);
  if (direct) return direct;

  // In some files there is a title phrase in the string that can masquerade as
  // the volume marker. Remove the known title phrases while keeping volume labels.
  const stripped = text
    .replace(/\bSongs of the Return\b/gi, '')
    .replace(/\b2920,\s*Morning Star\b/gi, '')
    .replace(/\bThe Lusty Argonian Maid\b/gi, '')
    .replace(/\s+/g, ' ')
    .replace(/\s*,\s*/g, ', ')
    .trim();

  const fallback = normalizeVolumeFromHeading(stripped);
  return fallback;
}
