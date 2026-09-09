# The Arcanaeum

A 90s-CD-ROM-styled web archive of the College of Winterhold library: the 249
in-game books of Skyrim, shelved, searchable to the word, with a live view of
which of them are actually on the shelf in game.

The text is Bethesda's, ported from the Library of Skyrim. **Read
[PROVENANCE.md](PROVENANCE.md) before publishing this anywhere.**

**Live: <https://arcanaeum.pages.dev>**

## Architecture

```
  INSERT                          CATALOGUE
  (the front page, every visit)       │
     │                                │
  DOM/CSS                          DOM/CSS
  a workstation on a stone desk;   shelf tablets
  the disc goes in, then the       + search
  monitor asks for the word            │        │
     │                                 │        └── /api/search ── FTS5
     └── /api/gate ── a writ           │                            │
                        │              └── /api/availability      D1
                        │                        │             tomes
              functions/api/_middleware   Google Sheets
              guards every other route  (the College's register)
```

**There is no reading screen.** The catalogue lists all 250 volumes and search
reads every word of them, but no route returns a book's text and clicking a
title opens nothing. That is deliberate — see *The volumes cannot be read*
below.

No framework, no 3D, no runtime dependency beyond anime.js and two self-hosted
fonts. The whole client is one ~56 KB bundle.

## The front door

`#/insert` is the archive's front page and every bare visit lands on it — it is
not a first-run title card, and there is no `visited` flag any more. A
workstation stands on a stone desk with a disc in front of it; the monitor
frames the archive; the disc goes into the drive, and the catalogue opens.
Reduced motion gets the same screen with the travel taken out of it rather than
being sent past it.

A link straight to `#/catalogue` or `#/tome/:id` still lands where it was sent.

The machine is one supplied plate. The drive slot, its light, the green lamp on
the tower and the desk are drawn in CSS, and every position on the plate is a
percentage of it, measured once — see the head of `src/styles/insert.css`.

| Route | Returns |
| --- | --- |
| `GET /api/tomes[?shelf=]` | Metadata only, never `body`. Excludes sealed books. |
| `GET /api/search?q=&shelf=&limit=` | Full-text over title, author and body, with excerpts. |
| `GET /api/resolve/:callNumber` | A call number to a shelf position, or 404. |
| `GET /api/availability` | What the College holds. `configured:false` if no register. |
| `GET /api/register` | How many readers have consulted the archive. |
| `POST /api/register/entry` | Counts this reader. |
| `GET`/`POST /api/gate` | The door. The only route outside the middleware. |

Every route except `/api/gate` is behind `functions/api/_middleware.ts` and
needs a valid writ. Two of them write: `/api/gate` sets a cookie, and
`/api/register/entry` takes no body, no parameters and no identifier and does
`visits = visits + 1` on a table with one row. Everything else is read-only,
and anything that is not a `GET` gets a 405.

## The door

The archive is behind a shared passphrase. The disc goes in, the monitor asks
for the word, and a correct one buys an HMAC-signed writ that lasts a week.

```bash
# a signing key neither you nor anyone else ever reads
node -e "process.stdout.write(require('crypto').randomBytes(32).toString('base64url'))" | npx wrangler pages secret put ARCANAEUM_GATE_SECRET --project-name arcanaeum
# the word itself, typed at the prompt
npx wrangler pages secret put ARCANAEUM_PASSPHRASE --project-name arcanaeum
```

**Two secrets, not one.** Signing with the passphrase would make a guessable
word into the key that mints admissions, and changing the word would forge every
writ already issued. Kept apart, the word can change without logging anybody
out, and everybody can be logged out — by bumping `ARCANAEUM_GATE_EPOCH` —
without changing the word.

**It fails closed.** A missing secret answers `503` and the archive is
unreadable until one is set. The alternative is that one lost secret silently
opens everything with nothing on any screen to say so.

**The prompt is scenery; the middleware is the boundary.** A reader can delete
the cookie, edit the bundle or call the routes with curl, and all of it gets
them a 401. What is *not* behind the door is the shell — the HTML, the bundle,
the fonts and the artwork — because a Function in front of every asset costs the
edge cache on all of them. Without the word you get an empty terminal and
nothing to read.

`npm run dev:vars` writes a throwaway local word (`winterhold`) so development
is not locked out of its own archive. The real one is a Pages secret and is not
in this repository.

## The volumes cannot be read

There is no reader. Clicking a title highlights the row and does nothing else,
`GET /api/tomes/:id` is gone, and no response from any route carries a `body`
column. Librarians catalogue these books; they are not meant to read them here.

**The one exception is the search excerpt**, about fourteen tokens around a
match, which is what makes a hit legible and is the whole point of searching
inside the volumes. Dropping `snippet(...)` from the SELECT in
`functions/api/search.ts` and `excerpt` from the client's `Hit` is the entire
change if that trade is ever judged the wrong way round.

## Run it

Node 20+. If `npm install` prints `allow-scripts`, esbuild and workerd need
theirs to fetch platform binaries:

```bash
npm install
npm approve-scripts esbuild && npm approve-scripts workerd && npm rebuild
```

Then:

```bash
npm run db:reset
npm run dev
```

`npm run dev` runs Vite building into `dist/` on save *and* `wrangler pages dev`
serving it with the D1 binding, from one command. <http://127.0.0.1:8788>.

Vite alone will not do — port 5173 has no API and no database, so every `/api`
route 404s.

**Windows:** if you get *"npm.ps1 cannot be loaded…"*, that is PowerShell's
execution policy, not this project. Use `npm.cmd run dev`, or run
`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` once.

## Deploy from a fresh Cloudflare account

```bash
npx wrangler login
npx wrangler d1 create arcanaeum          # paste database_id into wrangler.toml
npx wrangler d1 migrations apply arcanaeum --local
npx wrangler d1 migrations apply arcanaeum --remote
npx wrangler pages project create arcanaeum --production-branch main
npm run deploy
```

`database_id` is **not a secret** — an opaque account-scoped handle, useless
without your credentials, committed on purpose so the repo works after a clone.

Later deploys are just `npm run deploy`.

If the deployed API 500s while local works, the D1 binding did not carry over —
check **Workers & Pages → arcanaeum → Settings → Bindings** for `DB`.

### A Pages deploy is live before it is live

For a minute or so after `wrangler pages deploy`, the hostname serves the
previous bundle while `/api/*` can answer 404 in a way that reads exactly like a
broken Functions bundle. Poll until the served bundle hash matches
`dist/index.html` before judging any route.

## The books

249 books in `content/library/`, one markdown file each, generated by
`scripts/import-library.mjs` and committed.

```bash
npm run import      # re-fetch the corpus from the source site
npm run seed        # content/library/ -> the shelf migrations
npm run db:reset    # throw away the local D1 and re-apply everything
```

**Regenerating content means resetting the database.** Migrations are an
append-only ledger and `build-seed.mjs` rewrites the shelf migrations in place,
so after `npm run seed` the files no longer match what the ledger says was
applied and `migrations apply` will correctly do nothing. Locally that is
`npm run db:reset`. Remotely, the first shelf migration carries `DELETE FROM
tomes` and `DELETE FROM citations`, so re-applying is a reset — which is why
those two statements are there.

Adding a book means a *new* numbered migration, not a regenerated one.

### The restricted press

Five books are `restricted`, from the College's own `Restricted Titles` sheet,
mirrored in `content/restricted.json` with the librarians' reasons.

**They are listed on the shelf like everything else**, marked SEALED, shelved at
L1, searched with the rest and carrying their copy counts. They used to be held
out of the listing and reachable only by noticing a call number in a book you
could already read — but the College's register carries them openly, and
hiding a title was never access control (`/api/resolve` is public,
unauthenticated and unthrottled) only a game. A librarian who cannot see that
the College holds twenty copies of *Brothers of Darkness* cannot answer for it.

Nothing may go on that list that would matter if a stranger read it. Published
Bethesda books satisfy that trivially.

`npm run seed` reports a sealed book that no open book cites; it no longer
fails the build over one.

### The clock

The footer carries the realm's date and hour, reckoned in
`shared/reckoning.ts` — the Thalmor archive's module carried across whole
rather than re-derived, because two archives of the same realm disagreeing
about the day would be worse than either being wrong. **The rate is 2:1**, two
in-world minutes per real one, measured against the realm's own clock; the
anchor and the rate are the only two things to edit if the realm is ever re-set,
and they must be changed in both projects.

It ticks once a real second, which is the coarsest interval that never shows a
stale minute at 2:1. Everything is UTC: a reader in Cairo and one in Seattle
are told the same in-world hour.

It stands where `PORTED FROM THE LIBRARY OF SKYRIM` used to — see
[PROVENANCE.md](PROVENANCE.md).

### Searching

A body search puts **what the College actually holds first**, in its own group
above the shelf groups, tinted green where a copy is in. On the register — not
"available" — is what lifts a book into that group: a title the College owns but
has entirely lent out still belongs at the top of a librarian's answer, and its
AVAILABLE cell says `ALL OUT` in red so the two cases stay distinct.

The green is a second channel, not the only one: those rows are already at the
top. The full 249-row listing is left in call-number order — lighting up 48 of
them there would be a stripe pattern rather than an answer.

### The counter

`VISITORS` in the footer is a real number, ported from the Thalmor archive's
register with its per-country tally removed. One row, one integer, incremented
inside SQL — never read into JavaScript and written back, which is what makes
two readers arriving at once safe.

**Nothing identifying is stored or sent.** No address, no user agent, no
timestamp, no country, no row per visitor; there is deliberately nothing that
could answer "did this person come back". A browser is entered once a day,
deduped by a cookie whose value is the literal `1`, scoped to
`Path=/api/register/entry` so it never touches a cached route's cache key.

Crawlers are filtered by the shape of the request rather than by a user agent:
a `POST` carrying the browser's own `Sec-Fetch-Site: same-origin`,
`Sec-Fetch-Mode: cors` and a matching `Origin`, none of which page script can
forge and none of which is retained.

Every failure answers `204` — already counted, not a browser, no database, an
unapplied migration — so a prober cannot learn from the status code whether
they were recorded or whether there is a database at all. The odometer starts
empty and stays empty if the count never arrives; it never shows a made-up
number, which is what the old `0041982` was.

## The register

The catalogue's **COPIES** and **AVAILABLE** columns are read live from the
College's *Arcanaeum Records* spreadsheet through a Google service account,
read-only. The same two appear in a volume's running head.

Locally:

```bash
npm run dev:vars
```

That writes `.dev.vars` (gitignored) from the sibling Thalmor archive's key —
set `ARCANAEUM_SA_KEY` to point somewhere else. **Wrangler reads `.dev.vars`
at startup, so restart `npm run dev` after.** For the deployed site:

```bash
npx wrangler pages secret put GOOGLE_SERVICE_ACCOUNT_JSON --project-name arcanaeum
npx wrangler pages secret put ARCANAEUM_SHEET_ID --project-name arcanaeum
```

The sheet must be shared with the service account's `client_email` as a Viewer
or every read returns 403.

Without either secret `/api/availability` answers `configured: false`, both
columns are em dashes, the key is hidden, and the archive works exactly as it
did before there was a register. A catalogue that 500s because a spreadsheet is
down has the tail wagging the dog.

**Availability is derived, not read.** The register's own `Availability` column
says `In` on all 109 rows of it, so what counts is `Copies` against the open
rows of `Borrowed_Books` (status `Out` or `Overdue`) and `Library_Signouts`
(`Returned?` false).

**The two lists disagree about what a book is.** The register is a shelf list
and counts physical volumes — `The Real Barenziah, v1` … `v5`; the catalogue is
a reading list and holds the work as one entry. `shared/titles.ts` reduces a
volume to its work and the Worker sums the copies, which takes the match from
37 of 249 volumes to 48. It strips a trailing volume number and nothing else —
no fuzzy matching, because a wrong pairing would be invisible while an
unmatched title is reported and a librarian can fix a spelling.

201 of the 249 volumes are **not on the register at all**: the archive holds the
text, the College does not stock a copy. That reads as `—`, not as `ALL OUT` —
"we do not hold that" and "it is out until Tuesday" are different answers.

## Layout

```
content/library/   the books. Source of truth for the corpus.
content/           restricted.json and cross-references.json — the archive's own records
scripts/           import-library, build-seed, reset-local-db, dev
migrations/        0001 schema, 0002–0012 one shelf each, 0013 the search index
shared/            shelves and call-number shapes, used by client and API
functions/api/     the five routes, file-routed by Pages
functions/lib/     availability — the entire Google surface
src/screens/       insert, catalogue, reader
src/lib/           api, router, store, markdown, sound, rubrication
src/styles/        plain CSS, one file per screen
```

## Notes

**Anime.js over GSAP.** Anime is MIT and ~17 KB for what this needs — DOM
transforms and opacity on a handful of elements — while GSAP's weight and
licensing only start paying off at scrub-timelines and plugins nothing here
wants.

**Timers, not tweens, for anything a sequence depends on.** A backgrounded tab
produces no frames. The disc animation is decoration; the archive opens on a
timer whether or not a frame is ever drawn.

**Art.** `ASSETS.md` lists every plate the finished site wants, with dimensions
and subject, and what stands in procedurally until it exists.
