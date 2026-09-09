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

Every other visual in the project is drawn in CSS or generated procedurally —
the disc shell, the drive, the parchment, the stone tablets, the bevels, the
pixel cursor. `ASSETS.md` lists what is placeholder and what is final.

## The register

Availability comes from the College's own `Arcanaeum Records — Winterhold`
spreadsheet, read live and read-only through a Google service account. It holds
real member names, loan records and library-card data, so:

- The scope is `spreadsheets.readonly`. There is no write path in this codebase.
- Only three columns leave the Worker — title, location and a count. **No
  borrower name, no card number and no loan history is ever sent to a browser.**
- The credential is a Pages secret and is not in this repository.

## The music

`public/audio/librarytheme.mp3` and `public/audio/darkwave.mp3` were supplied by
the client. Provenance beyond that has not been established here; if they are to
be published, that is worth settling the same way as the text above.
