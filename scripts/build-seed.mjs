// Regenerates migrations/0002_seed_content.sql from the markdown in content/.
//
// The tomes are authored as plain markdown files with frontmatter so that the
// prose can be rewritten without anyone hand-editing SQL. Run:
//
//     node scripts/build-seed.mjs
//
// then re-apply migrations. Citations are not declared by hand -- they are
// extracted from the body text, so a call number mentioned in a tome is by
// definition a citation from it.

import { readFileSync, writeFileSync, readdirSync } from 'node:fs';
import { join } from 'node:path';

const CONTENT_DIR = 'content';
const OUT = 'migrations/0002_seed_content.sql';

/** Canonical schools. Kept in step with shared/schools.ts. */
const SCHOOLS = [
  'Destruction', 'Conjuration', 'Restoration', 'Illusion',
  'Alteration', 'Alchemy', 'History', 'Daedra',
];

const CALL_NUMBER = /\bAR-[IVXLCDM]+-\d{3}\b/g;
const ROMAN = { I: 1, V: 5, X: 10, L: 50, C: 100, D: 500, M: 1000 };

function romanValue(s) {
  let total = 0;
  for (let i = 0; i < s.length; i++) {
    const here = ROMAN[s[i]];
    const next = ROMAN[s[i + 1]];
    total += next > here ? -here : here;
  }
  return total;
}

/** Shelf-order sort: roman tier first, then accession number. */
function callNumberOrder(cn) {
  const [, tier, acc] = cn.match(/^AR-([IVXLCDM]+)-(\d+)$/);
  return romanValue(tier) * 100000 + Number(acc);
}

function parse(file) {
  const raw = readFileSync(join(CONTENT_DIR, file), 'utf8').replace(/\r\n/g, '\n');
  const lines = raw.split('\n');
  if (lines[0].trim() !== '---') throw new Error(`${file}: missing frontmatter`);
  const end = lines.indexOf('---', 1);
  if (end === -1) throw new Error(`${file}: unterminated frontmatter`);

  const meta = {};
  for (const line of lines.slice(1, end)) {
    if (!line.trim()) continue;
    const at = line.indexOf(':');
    if (at === -1) throw new Error(`${file}: bad frontmatter line "${line}"`);
    meta[line.slice(0, at).trim()] = line.slice(at + 1).trim();
  }

  const body = lines.slice(end + 1).join('\n').trim();

  for (const key of ['call_number', 'title', 'author', 'school', 'restricted']) {
    if (!(key in meta)) throw new Error(`${file}: frontmatter missing "${key}"`);
  }
  if (!SCHOOLS.includes(meta.school)) {
    throw new Error(`${file}: unknown school "${meta.school}"`);
  }
  if (!/^AR-[IVXLCDM]+-\d{3}$/.test(meta.call_number)) {
    throw new Error(`${file}: malformed call number "${meta.call_number}"`);
  }

  const cites = [...new Set(body.match(CALL_NUMBER) ?? [])]
    .filter((cn) => cn !== meta.call_number)
    .sort();

  return {
    call_number: meta.call_number,
    title: meta.title,
    author: meta.author,
    school: meta.school,
    restricted: meta.restricted === 'true' ? 1 : 0,
    body,
    cites,
  };
}

const q = (s) => `'${String(s).replace(/'/g, "''")}'`;

const tomes = readdirSync(CONTENT_DIR)
  .filter((f) => f.endsWith('.md'))
  .map(parse)
  .sort((a, b) => callNumberOrder(a.call_number) - callNumberOrder(b.call_number));

const byCallNumber = new Map(tomes.map((t, i) => [t.call_number, i + 1]));

// A citation pointing at nothing would be a dead end in the unlock mechanic,
// which reads as a bug rather than as mystery. Fail the build instead.
for (const t of tomes) {
  for (const cn of t.cites) {
    if (!byCallNumber.has(cn)) {
      throw new Error(`${t.call_number} cites ${cn}, which is not in ${CONTENT_DIR}/`);
    }
  }
}

const out = [];
out.push('-- Migration 0002 — seed content.');
out.push('--');
out.push('-- GENERATED FILE. Do not edit by hand: edit the markdown in content/');
out.push('-- and re-run `node scripts/build-seed.mjs`.');
out.push('--');
out.push('-- THESE TOMES ARE DRAFTS AND ARE INTENDED TO BE REPLACED. They are');
out.push('-- original fan writing set in the Elder Scrolls world, written to give');
out.push('-- the archive something to hold while the real text is prepared.');
out.push('');
out.push('DELETE FROM citations;');
out.push('DELETE FROM tomes;');
out.push('');

for (const [i, t] of tomes.entries()) {
  const id = i + 1;
  out.push(`-- ${t.call_number} — ${t.title}${t.restricted ? '  [RESTRICTED]' : ''}`);
  out.push('INSERT INTO tomes (id, call_number, title, author, school, body, restricted) VALUES');
  out.push(`  (${id}, ${q(t.call_number)}, ${q(t.title)}, ${q(t.author)}, ${q(t.school)},`);
  out.push(`   ${q(t.body)}, ${t.restricted});`);
  out.push('');
}

out.push('-- Citations, extracted from the call numbers appearing in each body.');
for (const [i, t] of tomes.entries()) {
  for (const cn of t.cites) {
    out.push(`INSERT INTO citations (from_tome, cites_call_number) VALUES (${i + 1}, ${q(cn)});`);
  }
}
out.push('');

writeFileSync(OUT, out.join('\n'), 'utf8');

const restricted = tomes.filter((t) => t.restricted);
console.log(`wrote ${OUT}`);
console.log(`  ${tomes.length} tomes (${restricted.length} restricted)`);
console.log(`  ${tomes.reduce((n, t) => n + t.cites.length, 0)} citations`);
for (const t of restricted) {
  const from = tomes.filter((o) => o.cites.includes(t.call_number)).map((o) => o.call_number);
  console.log(`  ${t.call_number} reachable from: ${from.join(', ') || 'NOWHERE'}`);
}
