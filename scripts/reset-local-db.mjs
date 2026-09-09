/**
 * Throw away the local D1 so the migrations can be applied from scratch.
 *
 *     npm run db:reset
 *
 * Migrations are an append-only ledger: wrangler records which files it has
 * applied and never runs one twice. scripts/build-seed.mjs breaks that contract
 * on purpose — it REWRITES the shelf migrations in place from the markdown, so
 * after regenerating the corpus the files on disk no longer match the ones the
 * ledger says were applied, and `migrations apply` correctly does nothing.
 *
 * Rather than pretend otherwise with a delta nobody could review, regenerating
 * content resets the database. Locally that is this script. Remotely it is the
 * two DELETEs that the first shelf migration carries, which is why they are
 * there — see the README.
 *
 * Local only, by construction: it deletes a directory inside .wrangler and has
 * no idea the remote exists.
 */

import { rmSync, existsSync } from 'node:fs';
import { join } from 'node:path';

const STATE = join('.wrangler', 'state', 'v3', 'd1');

if (existsSync(STATE)) {
  rmSync(STATE, { recursive: true, force: true });
  console.log(`removed ${STATE}`);
} else {
  console.log(`${STATE} was not there; nothing to remove`);
}
