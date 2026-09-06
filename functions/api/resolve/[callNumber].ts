// GET /api/resolve/:callNumber — turn a call number into a shelf position.
//
// THIS IS NOT ACCESS CONTROL. It is a lore device.
//
// Restricted tomes are hidden from the catalogue listing so that finding one
// feels like finding something. That is the whole of it. This endpoint is
// public, unauthenticated and unthrottled; anyone may enumerate call numbers
// and read every restricted body, and nothing here is meant to stop them.
// Nothing may be seeded into a restricted tome that would matter if it were
// read by a stranger, because it will be.
//
// If this project ever needs real access control, it does not go here. It goes
// behind an identity system that does not yet exist and is not planned.

import { CALL_NUMBER_RE } from '../../../shared/schools';
import { fail, json, param, readOnly, type RequestContext } from '../_lib';

interface Resolved {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
  restricted: number;
}

export const onRequest = readOnly(async (ctx: RequestContext) => {
  const raw = decodeURIComponent(param(ctx, 'callNumber')).trim().toUpperCase();

  if (!CALL_NUMBER_RE.test(raw)) {
    return fail('bad_request', 'That is not the shape of a call number.', 400);
  }

  const tome = await ctx.env.DB.prepare(
    'SELECT id, call_number, title, author, school, restricted FROM tomes WHERE call_number = ?',
  )
    .bind(raw)
    .first<Resolved>();

  if (tome === null) {
    return fail('not_found', 'The roll does not list that number.', 404);
  }

  return json(
    { ...tome, restricted: tome.restricted === 1 },
    200,
    'public, max-age=300',
  );
});
