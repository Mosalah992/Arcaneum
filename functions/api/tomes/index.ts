// GET /api/tomes           — the open shelves
// GET /api/tomes?shelf=... — one shelf
//
// `shelf` is the query parameter; `school` is still the column, because the
// column has always meant "which part of the library holds this" and renaming
// it would be a migration in exchange for nothing.
//
// Metadata only. `body` is never selected here, so no tome's text can leave
// through the listing whatever else changes about it.
//
// RESTRICTED TITLES ARE LISTED. They used to be filtered out and reachable
// only by noticing a call number in a book you could already read and typing it
// in. The College's own register carries them openly — they are on it with a
// location, a copy count and a librarian's note about why they are held in the
// restricted press — so the catalogue carries them openly too, marked SEALED
// and shelved at L1. Hiding a title was never access control (`/api/resolve`
// is public and unthrottled, and says so), only a game, and a librarian who
// cannot see that the College holds a book cannot answer for it.

import { canonicalShelf, SHELVES } from '../../../shared/shelves';
import { fail, json, readOnly, type RequestContext } from '../_lib';

interface TomeSummary {
  id: number;
  call_number: string;
  title: string;
  author: string;
  school: string;
  restricted: number;
}

// Rows are numbered in shelf order by the seed generator (tier, then
// accession), so id order is shelf order and needs no roman-numeral sort here.
const BASE = 'SELECT id, call_number, title, author, school, restricted FROM tomes';

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
    stmt = env.DB.prepare(`${BASE} WHERE school = ? ORDER BY id`).bind(shelf);
  }

  const { results } = await stmt.all<TomeSummary>();
  return json(
    { tomes: results.map((t) => ({ ...t, restricted: t.restricted === 1 })) },
    200,
    'public, max-age=60',
  );
});
