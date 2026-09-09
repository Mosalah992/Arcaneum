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

/*
 * ORDERED BY CALL NUMBER, WORKED OUT HERE, and not by `id`.
 *
 * The seed generator numbers rows in shelf order, so for a corpus written in
 * one pass `id` order and shelf order are the same thing — and every book added
 * afterwards has to be given an id in the middle of the sequence, which
 * renumbers every row after it and rewrites every migration that carries them.
 * One book cost the whole ledger.
 *
 * So `id` is an opaque key now and the order is derived from the call number it
 * is printed under: the shelf's position in SHELVES, then the accession number.
 * A new volume is a new row with the next free id, wherever its call number
 * puts it on the shelf. Sorting 250 rows in the Worker costs nothing.
 */
const BASE = 'SELECT id, call_number, title, author, school, restricted FROM tomes';

const ACCESSION = /-(\d+)$/;

function shelfOrder(tome: TomeSummary): number {
  const shelf = (SHELVES as readonly string[]).indexOf(tome.school);
  const accession = Number(ACCESSION.exec(tome.call_number)?.[1] ?? 0);
  // A shelf the catalogue does not know goes last rather than first, so a
  // mistyped `school` is visible at the end of the list instead of silently
  // heading it.
  return (shelf < 0 ? SHELVES.length : shelf) * 100_000 + accession;
}

export const onRequest = readOnly(async ({ request, env }: RequestContext) => {
  const raw = new URL(request.url).searchParams.get('shelf');

  let stmt;
  if (raw === null || raw === '') {
    stmt = env.DB.prepare(BASE);
  } else {
    const shelf = canonicalShelf(raw);
    if (shelf === null) {
      return fail(
        'bad_request',
        `No such shelf. The shelves are: ${SHELVES.join(', ')}.`,
        400,
      );
    }
    stmt = env.DB.prepare(`${BASE} WHERE school = ?`).bind(shelf);
  }

  const { results } = await stmt.all<TomeSummary>();
  const tomes = results
    .sort((a, b) => shelfOrder(a) - shelfOrder(b))
    .map((t) => ({ ...t, restricted: t.restricted === 1 }));
  return json({ tomes }, 200, 'public, max-age=60');
});
