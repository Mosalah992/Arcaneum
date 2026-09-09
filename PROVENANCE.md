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

- **The source is credited** in the footer of every page and in every book's
  frontmatter, and Bethesda is named as the author of the text.
- **`robots.txt` refuses indexing.** A fan archive that does not compete with
  its source in search results is a materially smaller ask than one that does,
  and it is the one thing here that can be done unilaterally.
- **Nothing is sold and nothing is monetised.** There is no advertising, no
  analytics, no tracking, and no third-party script of any kind.
- **The text is never edited.** Cross-references between books are the
  *archive's* apparatus, printed as a librarian's colophon set apart from the
  page — see `content/cross-references.json`. Not one word of the books
  themselves is altered, cut, or added to.

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
| `public/art/sigil.png` | Supplied by the client: the College's sigil, a rayed eye in a roundel. Cropped from 1050×1500 to its own bounds, 506×505 — as above. |

Every other visual in the project is drawn in CSS or generated procedurally —
the drive slot and its light, the stone desk the machine stands on, the
parchment, the stone tablets, the bevels, the pixel cursor. `ASSETS.md` lists
what is placeholder and what is final.

The two crops above were done once, by hand, and the cropped files are what is
committed. They are lossless in content — only fully transparent margin was
removed — but the originals as supplied are not in this repository, so keep
your own copies.

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

## The music

`public/audio/librarytheme.mp3` and `public/audio/darkwave.mp3` were supplied by
the client. Provenance beyond that has not been established here; if they are to
be published, that is worth settling the same way as the text above.
