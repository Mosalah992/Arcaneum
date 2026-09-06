// GET /api/tomes            — the open shelf
// GET /api/tomes?school=... — the open shelf, one school
//
// Metadata only. `body` is never selected here, so a restricted tome could not
// leak its text through the listing even if the WHERE clause were wrong.

import { canonicalSchool, SCHOOLS } from '../../../shared/schools';
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
  const raw = new URL(request.url).searchParams.get('school');

  let stmt;
  if (raw === null || raw === '') {
    stmt = env.DB.prepare(`${BASE} ORDER BY id`);
  } else {
    const school = canonicalSchool(raw);
    if (school === null) {
      return fail(
        'bad_request',
        `No such school. Known schools: ${SCHOOLS.join(', ')}.`,
        400,
      );
    }
    stmt = env.DB.prepare(`${BASE} AND school = ? ORDER BY id`).bind(school);
  }

  const { results } = await stmt.all<TomeSummary>();
  return json({ tomes: results }, 200, 'public, max-age=60');
});
