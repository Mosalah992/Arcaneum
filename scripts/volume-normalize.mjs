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

export function normalizeVolumeFromHeading(heading = '') {
  const text = String(heading || '').trim();
  if (!text) return '';

  const match = text.match(/\b(?:volume|vol(?:ume)?\.?|book|chapter|part)\b\s*(?:[.:\-]\s*)?((?:[ivxlcdm]+)|\d+)/i);
  if (!match) {
    const upper = text.toLowerCase();
    const volumeMatch = upper.match(/\bvolume\b\s+([ivxlcdm]+|\d+)/);
    if (volumeMatch) return `Volume ${volumeMatch[1]}`;
    return '';
  }

  const raw = match[1].trim();
  const numeric = /^[ivxlcdm]+$/i.test(raw) ? romanValue(raw.toUpperCase()) : Number(raw);
  if (!Number.isFinite(numeric)) return '';

  return `Volume ${numeric}`;
}

export function normalizeVolumeLabel(value = '') {
  const text = String(value || '').trim();
  if (!text) return '';

  // Accept the common expressing forms from body headings and frontmatter.
  const direct = normalizeVolumeFromHeading(text);
  if (direct) return direct;

  // If the content already has a real canonical value preserve it.
  if (/^Volume\s+\d+$/i.test(text)) return text.replace(/^volume\s+/i, 'Volume ');

  // In some files there is an author/title phrase in the string.
  // Remove boilerplate title words that can masquerade as the volume token.
  const stripped = text
    .replace(/\bSongs of the Return\b/gi, '')
    .replace(/\b2920,\s*Morning Star\b/gi, '')
    .replace(/\bThe Lusty Argonian Maid\b/gi, '')
    .replace(/\s+/g, ' ')
    .trim();

  const fallback = normalizeVolumeFromHeading(stripped);
  return fallback;
}
