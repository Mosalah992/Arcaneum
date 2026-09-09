// GET /api/availability
//
// What the College actually holds, so the catalogue can say whether a book a
// reader has found is on the shelf this afternoon.
//
// EVERY FAILURE IS SILENCE. No credential, no sheet, a refused read, a Google
// outage: this answers 200 with `configured: false` and the catalogue simply
// draws no chips. An archive that 500s because a spreadsheet is down has the
// tail wagging the dog, and the 249 books are readable either way.

import { json, readOnly, type RequestContext } from './_lib';
import { readRegister, type SheetsEnv } from '../lib/availability';

/**
 * How long a read is good for.
 *
 * The register changes when a librarian signs a book out, which is minutes
 * apart at best, and every visitor to the catalogue asks this question. Sixty
 * seconds keeps it current enough to be true and rare enough to be polite.
 */
const TTL = 60;

export const onRequest = readOnly(async (ctx: RequestContext) => {
  const env = ctx.env as unknown as SheetsEnv;

  if (
    env.GOOGLE_SERVICE_ACCOUNT_JSON === undefined ||
    env.ARCANAEUM_SHEET_ID === undefined
  ) {
    return json(
      { configured: false, reason: 'no register is connected', holdings: {} },
      200,
      'public, max-age=300',
    );
  }

  try {
    const register = await readRegister(env);
    return json(
      {
        configured: true,
        fetchedAt: register.fetchedAt,
        titles: Object.keys(register.holdings).length,
        /*
         * Titles the register names that no book here answers to.
         *
         * Returned rather than swallowed, and this is the point: the two lists
         * are typed by different people and will drift. A librarian can fix a
         * spelling, but only if something tells them which one — so the
         * mismatch is reported instead of quietly counting as "not held".
         */
        unmatched: register.unmatched,
        holdings: register.holdings,
      },
      200,
      `public, max-age=${TTL}, stale-while-revalidate=${TTL * 5}`,
    );
  } catch {
    // Deliberately no detail: a credential error should not describe itself to
    // the internet, and the client's behaviour is the same either way.
    return json(
      { configured: false, reason: 'the register could not be read', holdings: {} },
      200,
      'public, max-age=30',
    );
  }
});
