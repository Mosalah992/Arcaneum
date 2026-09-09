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
