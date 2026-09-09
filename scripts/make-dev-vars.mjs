// `npm run dev:vars` — put the register's credentials where wrangler will find
// them, so `npm run dev` reads the College's spreadsheet the way the deployed
// site does.
//
// WRANGLER READS .dev.vars VERBATIM. It does not strip quotes and it does not
// unescape, so the service-account JSON goes in minified onto one physical
// line and UNQUOTED. Wrapping it in quotes was the first version of this and it
// failed in the one way that is hard to see: `JSON.parse` of a quoted value
// returns a *string*, the signer then mints a JWT with `iss: undefined`,
// Google refuses the token, and /api/availability answers `configured: false`
// — which is exactly what it answers when no sheet has ever been connected.
//
// IT MERGES rather than rewriting. This file has one job today, but a
// .dev.vars overwritten from scratch takes every other value with it, and some
// secrets cannot be read back out of Cloudflare once lost. The sibling archive
// learned that the expensive way; this is its `setDevVar` carried across.
//
// The key itself is never printed. The account address is.

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

/** The College's register. The same id the deployed site is given. */
const SHEET_ID = '19VWm4h59iOhxIHXK25AvMFFh8Ul3UCIp2GRS-CEUTnE';

/**
 * Where the service-account key lives.
 *
 * `ARCANAEUM_SA_KEY` first, so a fresh machine can point at its own copy
 * without editing this file. The default is the sibling Thalmor archive, which
 * owns the account the sheet is shared with — this project has never held its
 * own copy of the key and does not want one.
 */
const KEY_PATH =
  process.env.ARCANAEUM_SA_KEY ??
  'C:/Centralized Archive/credentials/thalmor-service-account.json';

/**
 * Set one KEY=value in a .dev.vars body, leaving every other line as it was.
 *
 * A value can contain '=' — minified JSON is full of them — so the match is
 * anchored at the start of the line and stops at the first '='.
 */
export function setDevVar(existing, key, value) {
  const line = `${key}=${value}`;
  const lines = existing ? existing.split(/\r?\n/) : [];
  const at = lines.findIndex((l) => l.includes('=') && l.slice(0, l.indexOf('=')) === key);

  if (at >= 0) lines[at] = line;
  else {
    while (lines.length > 0 && lines[lines.length - 1].trim() === '') lines.pop();
    lines.push(line);
  }
  return `${lines.join('\n').replace(/\n+$/, '')}\n`;
}

/** Key names only. Values are secrets and never belong on a terminal. */
export const keysIn = (body) =>
  (body ? body.split(/\r?\n/) : [])
    .map((l) => l.slice(0, l.indexOf('=')))
    .filter((k) => /^[A-Z_][A-Z0-9_]*$/.test(k));

if (process.argv[1]?.endsWith('make-dev-vars.mjs')) {
  if (!fs.existsSync(KEY_PATH)) {
    console.error(`\n  No service-account key at ${KEY_PATH}`);
    console.error('  Set ARCANAEUM_SA_KEY to the path of your own copy.\n');
    process.exit(1);
  }

  // Round-trip through JSON.parse so a malformed key fails here rather than
  // inside a Worker that has been told to say nothing about why.
  const key = JSON.parse(fs.readFileSync(KEY_PATH, 'utf8').replace(/^\uFEFF/, ''));
  for (const field of ['client_email', 'private_key', 'token_uri']) {
    if (typeof key[field] !== 'string') {
      console.error(`\n  That key has no ${field}. Is it a service-account key?\n`);
      process.exit(1);
    }
  }

  const target = path.join(ROOT, '.dev.vars');
  const before = fs.existsSync(target) ? fs.readFileSync(target, 'utf8') : '';
  let after = setDevVar(before, 'GOOGLE_SERVICE_ACCOUNT_JSON', JSON.stringify(key));
  after = setDevVar(after, 'ARCANAEUM_SHEET_ID', SHEET_ID);
  fs.writeFileSync(target, after);

  const kept = keysIn(after).filter(
    (k) => k !== 'GOOGLE_SERVICE_ACCOUNT_JSON' && k !== 'ARCANAEUM_SHEET_ID',
  );
  console.log(`.dev.vars written for ${key.client_email}`);
  console.log(
    kept.length > 0
      ? `kept ${kept.length} other value${kept.length === 1 ? '' : 's'}: ${kept.join(', ')}`
      : 'no other values were present',
  );
  console.log('\nRestart `npm run dev` — wrangler reads .dev.vars at startup.');
}
