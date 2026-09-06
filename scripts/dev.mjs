// `npm run dev` — the whole archive, locally, from one command.
//
// The site is static files plus Pages Functions plus D1, and no single tool
// serves all three. Vite alone gives you the screens and a 404 from every API
// route; `wrangler pages dev` alone serves whatever was in dist/ the last time
// somebody remembered to build. So this runs both: Vite rebuilding into dist/
// on every save, and wrangler serving dist/ with the D1 binding attached.
//
// Both are spawned through this process's own node binary rather than through
// npx or a shell, which keeps it working on Windows where `npm` is a PowerShell
// script that an execution policy may refuse to run.

import { spawn } from 'node:child_process';
import { existsSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { join } from 'node:path';

const node = process.execPath;
const root = fileURLToPath(new URL('..', import.meta.url));

/**
 * Resolved by path rather than by `require.resolve`.
 *
 * Both packages declare an `exports` map and neither map exposes its `bin/`
 * directory, so `require.resolve('vite/bin/vite.js')` throws even though the
 * file is sitting right there.
 */
function bin(name, ...segments) {
  const path = join(root, 'node_modules', ...segments);
  if (existsSync(path)) return path;
  console.error(`\n  Cannot find ${name} at ${path}. Run: npm install\n`);
  process.exit(1);
}

const vite = bin('vite', 'vite', 'bin', 'vite.js');
const wrangler = bin('wrangler', 'wrangler', 'bin', 'wrangler.js');

const children = [];

function run(label, path, args) {
  const child = spawn(node, [path, ...args], { stdio: ['ignore', 'pipe', 'pipe'] });
  const write = (stream) => (chunk) => {
    for (const line of String(chunk).split('\n')) {
      if (line.trim() !== '') stream.write(`[${label}] ${line}\n`);
    }
  };
  child.stdout.on('data', write(process.stdout));
  child.stderr.on('data', write(process.stderr));
  child.on('exit', (code) => {
    if (!stopping) {
      console.error(`\n  ${label} exited (${code}). Shutting down.\n`);
      stop(code ?? 1);
    }
  });
  children.push(child);
  return child;
}

let stopping = false;
function stop(code) {
  if (stopping) return;
  stopping = true;
  for (const child of children) child.kill();
  process.exit(code);
}

process.on('SIGINT', () => stop(0));
process.on('SIGTERM', () => stop(0));

// Vite first, and wrangler only once dist/ actually exists — starting wrangler
// against a missing output directory is a confusing first-run failure.
const builder = run('vite', vite, ['build', '--watch']);

let started = false;
builder.stdout.on('data', (chunk) => {
  if (started || !String(chunk).includes('built in')) return;
  started = true;
  run('wrangler', wrangler, ['pages', 'dev', '--port', '8788']);
  console.log('\n  The Arcanaeum is at http://127.0.0.1:8788\n');
});
