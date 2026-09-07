# The Arcanaeum

A 90s-CD-ROM-styled web archive of the College of Winterhold library. Original
fan writing, set in the Elder Scrolls world.

**Live: <https://arcanaeum.pages.dev>**

## Architecture

```
  BOOT            GATE               CATALOGUE           TOME
   │               │                     │                 │
 DOM/CSS        three.js              DOM/CSS           DOM/CSS
 fake CD        well + gate           pixel search      two-page
 sequence       only                  + results         spread
                                          │                 │
                                          └──── D1 ─────────┘
                                    tomes / citations
```
