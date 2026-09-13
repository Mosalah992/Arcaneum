const ROMAN = { I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000 };

function romanValue(s) {
  let total = 0;
  for (let i = 0; i < s.length; i++) {
    const here = ROMAN[s[i]] ?? 0;
    const next = ROMAN[s[i + 1]] ?? 0;
    total += next > here ? -here : here;
  }
  return total;
}

function parseVolumeNumber(raw = '') {
  const token = String(raw || '').trim();
  if (!token) return NaN;
  if (/^[ivxlcdm]+$/i.test(token)) return romanValue(token.toUpperCase());
  const numeric = Number(token);
  return Number.isFinite(numeric) ? numeric : NaN;
}

export function normalizeVolumeFromHeading(heading = '') {
  const text = String(heading || '').trim();
  if (!text) return '';

  const cleaned = text
    .replace(/^#+\s*/, '')
    .replace(/\b(?:the)\b\s+/i, ' ')
    .trim();

  const match = cleaned.match(/\b(?:volume|vol(?:ume)?\.?|book|chapter|part)\b\s*(?:[.:\-]\s*)?([ivxlcdm]+|\d+)/i);
  if (!match) {
    const explicit = cleaned.match(/\bvolume\b\s+([ivxlcdm]+|\d+)/i);
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
