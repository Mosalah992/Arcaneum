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
| `art/well.png` | 1536×1024 | **unused** | Ten-frame sheet, 5×2, of a rune-carved magicka font. The well was removed from the chamber; the file is kept in case it is wanted again, and nothing loads it. |
| `art/rubrication.png` | 1536×1024 | `src/lib/rubrication.ts` | Illuminated manuscript elements — decorated initials, a dragon border, sun, hare, raven, stag, hound, snail, compass rose, scribe, wizard — cut out on transparency. |

### `art/well.png` — no longer used

The well was removed from the chamber. The magicka wells straight up out of the
floor now, as point sprites, and nothing loads this sheet. The file is left in
place rather than deleted, in case it is wanted again.

If it is ever brought back, **export it as 32-bit PNG with a real alpha
channel** first. The current file is 24-bit colour with the transparency
checkerboard flattened into the pixels, so the grey squares are real image data
and no key can fully undo it: where the glow was semi-transparent, the flatten
mixed it *with* the checker and the true colour is gone.

### `art/rubrication.png`

Has a real alpha channel and needs nothing. At 2.9 MB it is heavy for a phone —
it loads with the reader, so it does not block first paint, but WebP at quality
~85 would put it near 250 KB with no visible loss at the size it is drawn. That
needs an image-processing dependency (`sharp`) which is not in the spec's list,
so it has not been added — say the word.

---

## To paint

### Chamber — currently procedural canvas textures

| File | Size | Where | Subject |
| --- | --- | --- | --- |
| `art/chamber/wall.png` | 128×128 | `stoneTexture()` | Tiling coursed stone, cold grey-blue, heavy mortar joints, worn. Must tile seamlessly on both axes. |
| `art/chamber/floor.png` | 128×128 | `stoneTexture()` | Tiling flagstone, darker and smoother than the wall, damp. Seamless. |
| `art/chamber/mote.png` | 128×128 | `moteTexture()` | One mote of magicka: a hard-edged blue-white dot with a stepped falloff, on transparency. No soft blur — it is drawn with `NearestFilter`. |
| `art/chamber/gate-runes.png` | 256×256 | `runeTexture()` | Greyscale emissive mask for the gate doors: warding marks in a ring around a central sigil. White glows, black does not. |
| `art/chamber/gate-doors.png` | 512×512 | not yet used | Albedo for the two door leaves — dark iron-bound timber, banded, with the ward channels cut in. |
| `art/chamber/board-sigil.png` | 256×256 | `.board__sigil` | The College's mark, embossed on the inside of the front board. Currently a CSS lozenge with a glyph in it. |

### Interface

| File | Size | Where | Subject |
| --- | --- | --- | --- |
| `art/ui/cursor-hand.png` | 32×32 | `.chamber--gate` | Pixel-art pointing hand, 1-bit outline with a parchment fill. Currently an inline SVG built from rectangles. |
| `art/ui/cursor-hand@2x.png` | 64×64 | `.chamber--gate` | The same at double density. |
| `art/ui/tablet.png` | 200×40 | `.tablet` | Carved stone tablet for the school filters, engraved and beveled. Currently CSS gradients and box-shadow, which is convincing enough that this is optional. |
| `art/ui/seal.png` | 64×64 | `.title-page__seal`, `.seal` | A burgundy wax seal, broken, for restricted volumes. Currently a flat burgundy chip. |
| `art/ui/parchment.png` | 512×512 | `.page` | Tiling aged paper: foxing, water stains, fibre. Currently layered radial gradients plus an SVG turbulence grain. Seamless. |

### Site

| File | Size | Where | Subject |
| --- | --- | --- | --- |
| `favicon-16.png` | 16×16 | `index.html` | The College sigil at bitmap size. Not yet referenced. |
| `favicon-32.png` | 32×32 | `index.html` | As above. |
| `apple-touch-icon.png` | 180×180 | `index.html` | As above, on an obsidian ground. |
| `og-image.png` | 1200×630 | `index.html` | The chamber with the well lit, gate behind, title set in bitmap type. |

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
| `audio/grind.wav` | ~900 ms | `grind` | Stone on stone, low, as the gate parts. |
| `audio/unlock.wav` | ~800 ms | `unlock` | The wards taking the light — four rising steps and a shimmer. |

### Music

Two looped tracks, both under the one MUSIC toggle. The archive's theme plays
everywhere; opening a volume switches to the reading track and closing it
switches back.

| File | Where | Status |
| --- | --- | --- |
| `audio/librarytheme.mp3` | boot, chamber, catalogue | supplied, 563 KB |
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
