// GET /api/tomes/:id — one tome, full body.

import { fail, json, param, readOnly, type RequestContext } from '../_lib';

interface Tome {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
  body: string;
  restricted: number;
}

export const onRequest = readOnly(async (ctx: RequestContext) => {
  const raw = param(ctx, 'id');
  const id = Number(raw);

  if (!/^\d{1,9}$/.test(raw) || !Number.isSafeInteger(id) || id < 1) {
    return fail('bad_request', 'A call slip carries a whole number.', 400);
  }

  const tome = await ctx.env.DB.prepare(
    'SELECT id, call_number, title, author, school, body, restricted FROM tomes WHERE id = ?',
  )
    .bind(id)
    .first<Tome>();

  if (tome === null) {
    return fail('not_found', 'No such volume is held.', 404);
  }

  return json(
    { ...tome, restricted: tome.restricted === 1 },
    200,
    'public, max-age=300',
  );
});
