// GET /api/register — how many readers have consulted the archive.
//
// Read-only, and separate from the entry route because it answers a different
// question: entry is "count me", this is "what is the count". A reader whose
// browser has already been entered today gets a 204 from the other one, and
// still wants to see the number.
//
// Not cached at the edge. It is one integer out of a table with one row, and a
// counter that lags a minute behind itself looks broken in the one way a
// counter can.

import { json, readOnly, type RequestContext } from '../_lib';
import { COUNT_SQL } from '../../lib/register';

export const onRequest = readOnly(async (ctx: RequestContext) => {
  try {
    const row = await ctx.env.DB.prepare(COUNT_SQL).first<{ visits: number }>();
    // `configured: false` rather than a 500 or a zero, so the footer can hide
    // the counter entirely instead of showing a number it does not have. A
    // fabricated nought is what the old decorative counter was.
    if (row === null) return json({ configured: false }, 200, 'no-store');
    return json({ configured: true, visits: row.visits }, 200, 'no-store');
  } catch {
    return json({ configured: false }, 200, 'no-store');
  }
});
