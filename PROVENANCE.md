# Provenance

What this archive holds, where it came from, and what that does and does not
settle.

## The books

The 249 volumes in `content/library/` are the in-game books of *The Elder
Scrolls V: Skyrim*. **The text is Bethesda Softworks'.** It was written for
their game, it is their copyright, and nothing here changes that.

It was ported from **The Library of Skyrim**, <https://skyrimbooksproj.web.app>,
by `scripts/import-library.mjs`. Every book records the page it came from in its
own frontmatter:

```
source: https://skyrimbooksproj.web.app/books/history-lore/the-great-war
```

### What is not resolved

That site carries **no licence, no terms, and no repository**. Its About link
returns 404. So porting from it settles neither of the two permissions this
archive would need:

1. Bethesda's, for their text.
2. The Library of Skyrim's, for the labour of transcribing and arranging it.

Neither has been sought and neither has been granted. This is a fan archive
standing on a fan archive, and it is recorded here rather than buried so that
anyone deciding what to do with it can see the position clearly.

### What has been done about it

- **Bethesda is credited in the footer of every page**, and every book records
  the Library of Skyrim page it was ported from in its own `source:`
  frontmatter.

  **The footer no longer names the Library of Skyrim.** It read `PORTED FROM
  THE LIBRARY OF SKYRIM` until the client asked for that line to make room for
  the realm's clock. The credit still exists — here, and on all 249 books — but
  it is no longer on screen, and that is a smaller acknowledgement than it was.
  Worth reversing if this is ever published.
- **`robots.txt` refuses indexing.** A fan archive that does not compete with
  its source in search results is a materially smaller ask than one that does,
  and it is the one thing here that can be done unilaterally.
- **Nothing is sold and nothing is monetised.** There is no advertising, no
  tracking, and no third-party script of any kind.
- **The text is never edited.** Not one word of any book is altered, cut, or
  added to.
- **The volumes cannot be read on the site.** There is no reading screen, no
  route returns a book's `body`, and clicking a title opens nothing. The
  catalogue is a catalogue. The only text that reaches a browser is a
  fourteen-token excerpt around a search match — see the note in
  `functions/api/search.ts`.
- **The archive is behind a passphrase.** Every `/api/*` route needs a writ, so
  a stranger without the College's word gets an empty terminal.

### If a takedown is asked for

`content/library/` is 249 plain markdown files and the shelf migrations are
generated from them. Removing the corpus is deleting one directory and
re-running `npm run seed`. Nothing else in the project depends on the books
being those particular books.

## The art

| Asset | Origin |
| --- | --- |
| `public/art/rubrication.png` | Supplied by the client. Illuminated manuscript elements on transparency. |
| `public/art/floppydisk.png` | Supplied by the client: a 3.5" disc bearing the College of Winterhold sigil. |
| `public/art/background.png` | Supplied by the client: a period workstation with the College painted on its screen. Cropped from 1050×1500 to 1050×1050 — transparent margin removed, nothing resampled. |

Every other visual in the project is drawn in CSS or generated procedurally —
the drive slot and its light, the stone desk the machine stands on, the
parchment, the stone tablets, the bevels, the pixel cursor. `ASSETS.md` lists
what is placeholder and what is final.

The crop above was done once, by hand, and the cropped file is what is
committed. It is lossless in content — only fully transparent margin was
removed — but the original as supplied is not in this repository, so keep your
own copy.

`public/art/sigil.png` was supplied and used on every volume's inside cover; it
was deleted when the reader was, having nowhere left to go. It is in the history
at `c603c25`.

## The register

Availability comes from the College's own **Arcanaeum Records** spreadsheet,
read live and read-only through the `ancarion@thalmor.iam.gserviceaccount.com`
service account. That workbook has fourteen tabs and most of them are none of
this archive's business: `Library Cards`, `Card Holder Records`, `Money_Ledger`,
`Book Sales`, `Requests`, `Budget_Summary`. It holds real member names, loan
records, collateral sums and library-card data, so:

- The scope is `spreadsheets.readonly`. There is no write path in this codebase.
- **Four tabs are read and no others**: `Book_Index`, `Borrowed_Books`,
  `Library_Signouts`, `Restricted Titles`. The ranges are pinned in
  `functions/lib/availability.ts` and stop at the last column that matters.
- **What leaves the Worker is a title, a location, three numbers and the
  librarians' note on a restricted title.** The borrower columns — `Guest`,
  `Name`, `Handling Librarian`, `Collateral`, `Strikes` — are read to count how
  many copies are out and are then thrown away. No name, no card number and no
  loan history is ever sent to a browser.
- The credential is a Pages secret. It is not in this repository and this
  project has never held its own copy: `npm run dev:vars` reads the sibling
  Thalmor archive's key and writes `.dev.vars`, which is gitignored.

## The counter

The footer's `VISITORS` figure is real, and it is the only thing this site
writes down about anybody. It is **one integer in one row**: no address, no
user agent, no timestamp, no country, and no row per visitor. There is
deliberately nothing stored that could answer "did this person come back".

A browser is counted once a day, deduped by a cookie whose value is the literal
`1` — not a nonce, not a hash, not an id — scoped to the single URL
`/api/register/entry` so it is never sent with any other request. Two visits
from one browser and two visits from two browsers are indistinguishable in
everything that is kept, which is the point: a counter that can tell readers
apart is a tracker whatever it is called.

The design is ported from the Thalmor archive's register of consultation, minus
its per-country tally.

## The music

`public/audio/librarytheme.mp3` and `public/audio/darkwave.mp3` were supplied by
the client. Provenance beyond that has not been established here; if they are to
be published, that is worth settling the same way as the text above.
