# ASSETS

Everything the finished site needs painted, and what is standing in for it now.

Nothing here was generated or downloaded as stand-in artwork. Where a plate is
missing, the site draws a procedural placeholder — a canvas texture, a CSS
gradient, an SVG built from rectangles — so the shape and the space are right
and the real plate drops into the same slot.

Paths are relative to `public/`, which Vite copies into `dist/` verbatim. A
file placed anywhere else — including `dist/assets/` — is deleted on the next
build, because `vite build` empties `dist/` first.

---

## Supplied

| File | Size | Where | Subject |
| --- | --- | --- | --- |
| `art/rubrication.png` | 1536×1024 | `src/lib/rubrication.ts` | Illuminated manuscript elements — decorated initials, a dragon border, sun, hare, raven, stag, hound, snail, compass rose, scribe, wizard — cut out on transparency. |
| `art/floppydisk.png` | 1278×1230 | `.disc` | The whole 3.5" disc — navy shell, brushed shutter, label and the College's sigil — on transparency. Drawn at ~210px, smooth-resampled rather than `pixelated`: it is a soft render, and nearest-neighbour on a downscale of one aliases badly. |

### `art/floppydisk.png`

Supplied and in use. At 1.07 MB it is the second-heaviest thing the site sends
and it is on the first screen a new visitor sees — worth the same WebP pass as
the rubrication sheet, which would put it near 80 KB with no visible loss at the
size it is drawn.

`art/well.png` was deleted with the chamber.

### `art/rubrication.png`

Has a real alpha channel and needs nothing. At 2.9 MB it is heavy for a phone —
it loads with the reader, so it does not block first paint, but WebP at quality
~85 would put it near 250 KB with no visible loss at the size it is drawn. That
needs an image-processing dependency (`sharp`) which is not in the spec's list,
so it has not been added — say the word.

---

## To paint

### Shelf devices — three shelves are borrowing

Eight painted devices serve eleven shelves. `src/lib/rubrication.ts` states the
convention and which three borrow; these would end the borrowing.

| File | Size | Where | Subject |
| --- | --- | --- | --- |
| `art/devices/notes-letters.png` | ~300×300 | `BY_SHELF['Notes & Letters']` | A folded letter with a broken seal, illuminated in the sheet's hand. Currently borrows the snail. |
| `art/devices/plays-poetry.png` | ~300×300 | `BY_SHELF['Plays, Poetry & Riddles']` | A mask, or a lute with a vine. Currently borrows the hare. |
| `art/devices/politics-law.png` | ~300×300 | `BY_SHELF['Politics & Law']` | A pair of scales, or a sealed writ. Currently borrows the compass rose. |

Painted on transparency, in the style of `rubrication.png`. They can be added to
that sheet instead — `rubrication.ts` addresses ornaments by bounding box, so a
new element only needs its box recorded.

### Illustrations dropped from the books

Ten imported books carry an image the port did not bring across. The prose reads
without them; each is a plate from the source site.

| Book | Images |
| --- | --- |
| `AR-II-005` The Nightingales | nightingales.png |
| `AR-II-008` Shadowmarks | shadowmark1–9.png |
| `AR-IV-031` A Minor Maze | minormaze.png |
| `AR-V-008` Atronach Forge Manual | daedric-rune.png |
| `AR-V-015` Dragon Language: Myth no More | dragon-lang1–5.png |
| `AR-V-018` Dwemer Inquiries | dwemer-inquiries3, 5, 6.png |
| `AR-V-027` Herbalist's Guide to Skyrim | eight reagent plates |
| `AR-V-029` Horker Attacks | horker1–2.png |
| `AR-V-046` Troll Slaying | troll-slaying.png |
| `AR-VIII-007` King Olaf's Verse | olafverse1.png |

`scripts/import-library.mjs` reports these on every run rather than dropping
them silently. Bringing them in means hosting the files and teaching
`src/lib/markdown.ts` an image block — neither is done.

### Interface

| File | Size | Where | Subject |
| --- | --- | --- | --- |
| `art/ui/tablet.png` | 200×40 | `.tablet` | Carved stone tablet for the shelf filters, engraved and beveled. Currently CSS gradients and box-shadow, which is convincing enough that this is optional. |
| `art/ui/seal.png` | 64×64 | `.title-page__seal`, `.seal` | A burgundy wax seal, broken, for restricted volumes. Currently a flat burgundy chip. |
| `art/ui/parchment.png` | 512×512 | `.page` | Tiling aged paper: foxing, water stains, fibre. Currently layered radial gradients plus an SVG turbulence grain. Seamless. |

### Site

| File | Size | Where | Subject |
| --- | --- | --- | --- |
| `favicon-16.png` | 16×16 | `index.html` | The College sigil at bitmap size. Not yet referenced. |
| `favicon-32.png` | 32×32 | `index.html` | As above. |
| `apple-touch-icon.png` | 180×180 | `index.html` | As above, on an obsidian ground. |
| `og-image.png` | 1200×630 | `index.html` | The disc going into the drive, title set in bitmap type. Note robots.txt refuses indexing — see PROVENANCE.md. |

---

## Sound

The four cues are synthesised in Web Audio at runtime (`src/lib/sound.ts`) —
oscillators and a noise buffer, which is what an 8-bit cue is. They cost no
bytes and cannot fail to load. Replacing them means dropping files in and
changing `play()`, nothing else.

| File | Length | Cue | Subject |
| --- | --- | --- | --- |
| `audio/tick.wav` | ~40 ms | `tick` | A dry blip as the cursor crosses something that answers. |
| `audio/page.wav` | ~250 ms | `page` | One leaf turning. Paper, no tone. |
| `audio/grind.wav` | ~900 ms | `grind` | The drive taking the disc. Was the gate grinding open. |
| `audio/unlock.wav` | ~800 ms | `unlock` | Four rising steps and a shimmer. Unused since the gate went; kept for the sealed shelf. |

### Music

Two looped tracks, both under the one MUSIC toggle. The archive's theme plays
everywhere; opening a volume switches to the reading track and closing it
switches back.

| File | Where | Status |
| --- | --- | --- |
| `audio/librarytheme.mp3` | insert, catalogue | supplied, 563 KB |
| `audio/darkwave.mp3` | the reader, while a volume is open | supplied, 367 KB |

If a track ever fails to load, the archive's theme takes over rather than the
volumes going silent. Worth knowing: Cloudflare Pages serves its SPA fallback
for an unknown path, so a missing mp3 arrives as **200 with `text/html`**, not
a 404 — which is exactly how it looks when a file has been added locally but
not deployed.

`audio/librarytheme.mp3`, 563 KB, is looped under the MUSIC toggle. It
is **off by default and never starts on its own** — the brief rules out an
autoplaying ambient track. The preference is remembered, so anyone who turns it
on gets it back on their next visit at the first gesture a browser will allow.
