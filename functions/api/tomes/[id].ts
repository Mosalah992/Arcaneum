// GET /api/tomes/:id — one tome, full body, and what else the roll holds.

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

  /*
   * The colophon.
   *
   * Folded into this response rather than given its own route: the reader wants
   * it on every book it opens and never on its own, so a second round trip
   * would buy nothing but latency.
   *
   * Only the call numbers travel, never the titles. Naming a sealed book here
   * would hand over the discovery — the whole mechanic is that a reader meets a
   * number and asks for it at the desk.
   */
  const { results: refers } = await ctx.env.DB.prepare(
    `SELECT c.cites_call_number AS call_number
       FROM citations c
       JOIN tomes t ON t.call_number = c.cites_call_number
      WHERE c.from_tome = ?
      ORDER BY c.cites_call_number`,
  )
    .bind(id)
    .all<{ call_number: string }>();

  return json(
    {
      ...tome,
      restricted: tome.restricted === 1,
      refers: refers.map((r) => r.call_number),
    },
    200,
    'public, max-age=300',
  );
});
