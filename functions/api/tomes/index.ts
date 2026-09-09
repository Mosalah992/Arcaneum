// GET /api/tomes           — the open shelves
// GET /api/tomes?shelf=... — one shelf
//
// `shelf` is the query parameter; `school` is still the column, because the
// column has always meant "which part of the library holds this" and renaming
// it would be a migration in exchange for nothing.
//
// Metadata only. `body` is never selected here, so a restricted tome could not
// leak its text through the listing even if the WHERE clause were wrong.

import { canonicalShelf, SHELVES } from '../../../shared/shelves';
import { fail, json, readOnly, type RequestContext } from '../_lib';

interface TomeSummary {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
}

// Rows are numbered in shelf order by the seed generator (tier, then
// accession), so id order is shelf order and needs no roman-numeral sort here.
const BASE =
  'SELECT id, call_number, title, author, school FROM tomes WHERE restricted = 0';

export const onRequest = readOnly(async ({ request, env }: RequestContext) => {
  const raw = new URL(request.url).searchParams.get('shelf');

  let stmt;
  if (raw === null || raw === '') {
    stmt = env.DB.prepare(`${BASE} ORDER BY id`);
  } else {
    const shelf = canonicalShelf(raw);
    if (shelf === null) {
      return fail(
        'bad_request',
        `No such shelf. The shelves are: ${SHELVES.join(', ')}.`,
        400,
      );
    }
    stmt = env.DB.prepare(`${BASE} AND school = ? ORDER BY id`).bind(shelf);
  }

  const { results } = await stmt.all<TomeSummary>();
  return json({ tomes: results }, 200, 'public, max-age=60');
});
