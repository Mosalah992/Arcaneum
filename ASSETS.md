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
| `art/rubrication.png` | 1536×1024 | **nothing, currently** | Illuminated manuscript elements — decorated initials, a dragon border, sun, hare, raven, stag, hound, snail, compass rose, scribe, wizard — cut out on transparency. |
| `art/floppydisk.png` | 1278×1230 | `.disc` | The whole 3.5" disc — navy shell, brushed shutter, label and the College's sigil — on transparency. Drawn at ~210px, smooth-resampled rather than `pixelated`: it is a soft render, and nearest-neighbour on a downscale of one aliases badly. |
| `art/background.png` | 1050×1050 | `.rig` | The workstation: CRT, tower, keyboard and base unit, on transparency, with the College painted on the glass. The front page. |
| `art/sigil.png` | 506×505 | **nothing, currently** | The College's sigil — a rayed eye in a roundel. |

### Orphaned when the reader was removed

`art/sigil.png` was blocked into the inside of every volume's front board and
set at the head of the title page on narrow screens. `art/rubrication.png` was
the sheet the tailpiece was cut from, and `src/lib/rubrication.ts` — the
connected-component labeller that isolated an ornament from its neighbours — has
been deleted with it. `audio/darkwave.mp3` was the reading track and nothing
asks for it any more.

All three are still in the repository. The sigil in particular wants a new home
— the front page or the catalogue's header are the obvious candidates — and it
is a supplied plate sitting unused until it gets one.

### `art/background.png`

Supplied as 1050×1500 with the machine occupying y 338..1149 — 30% of the
picture was transparent air. Because the plate is fitted to the shorter axis of
the window, that air was what set the machine's size on screen: 630px across on
a 1440×900 window, with a third of the screen empty either side. **Cropped to
1050×1050**, the machine plus the stone the disc lands on, which takes it to
900px across on the same window. No pixel was resampled.

Every position on it — the glass, the drive slot, its light, the tower lamp,
the disc's rest — is a percentage of the plate, measured once and recorded in
`src/styles/insert.css`. Repaint the machine at the same framing and nothing
needs moving; reframe it and those percentages are the list of what to
re-measure.

The plate has **no floppy slot**. The base unit's front is a clean run of case,
so the slot, its light and the desk under the machine are drawn in CSS.

### `art/sigil.png`

Supplied as 1050×1500 with the sigil in the middle of it. **Cropped to its own
bounds**, 506×505, which is the whole change — the transparent margin held no
information and was four fifths of the file.

At 409 KB it is heavy for its size, and the reason is the halftone stipple the
sigil is drawn with: two-value noise across every flat area is the worst case
for PNG's filters. WebP at quality ~88 would take it under 60 KB. Same `sharp`
question as the rubrication sheet, below.

### `art/floppydisk.png`

Supplied and in use. At 1.07 MB it is heavy, and it is on the front page, which
every visit now starts on rather than only the first — worth the same WebP pass
as the rubrication sheet, which would put it near 80 KB with no visible loss at
the size it is drawn.

Its transparent margins matter to the layout rather than to the file size: the
disc itself is 78.87% of the plate's width, offset 11.58% from the left edge,
and the drive slot is sized and centred to *that* rather than to the element
carrying it. Recrop this plate and those two numbers in `insert.css` change.

`art/well.png` was deleted with the chamber.

### `art/rubrication.png`

Has a real alpha channel and needs nothing. At 2.9 MB it is heavy for a phone —
it loads with the reader, so it does not block first paint, but WebP at quality
~85 would put it near 250 KB with no visible loss at the size it is drawn. That
needs an image-processing dependency (`sharp`) which is not in the spec's list,
so it has not been added — say the word.

---

## To paint

### Shelf devices — retired, not outstanding

There used to be three plates wanted here: eight painted devices from the
rubrication sheet were serving eleven shelves, so Notes & Letters borrowed the
snail, Plays borrowed the hare and Politics borrowed the compass rose.

**There is no longer a per-shelf device.** Every volume opens on the College's
own sigil, blocked into the inside of the front board, and the shelf is named
in words on the title page. One mark, the same on all 249, said once — which is
what the College would actually have done. `BY_SHELF` and the dragon headpiece
went with it; `src/lib/rubrication.ts` now cuts one ornament from the sheet,
the tailpiece that closes a volume.

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

### A face for the reading aid

`READING AID` in a volume's running head switches to `--font-aid`, which is a
system sans stack — nothing is downloaded, so it cannot fail to load and costs
nothing until it is switched on. Most of the work is done by the spacing,
measure and flattened ground that come with it, which is where the evidence
actually is; the dyslexia-specific typefaces test far less clearly than their
reputation suggests.

If one is wanted anyway, it is two lines in `src/styles/reader.css`: an
`@font-face` and the first entry of `--font-aid`. **OpenDyslexic** is SIL
Open Font License and free to self-host. **Atkinson Hyperlegible** is also OFL
and available from `@fontsource/atkinson-hyperlegible`, which would be the
project's first new runtime dependency — worth asking before adding.

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
