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

Three.js renders the chamber, the well and the gate. Every other pixel is DOM
and CSS. Three.js is a dynamic import in its own ~529 KB chunk — reduced-motion
visitors and anyone going straight to the catalogue never download it. Keep it
that way: importing from `three` outside `src/screens/chamber.ts` pulls it into
the main bundle.

The API is read-only. No `POST`, no login, no admin, no analytics; anything
that is not a `GET` gets a 405.

| Route | Returns |
| --- | --- |
| `GET /api/tomes[?school=]` | Metadata only, never `body`. Excludes restricted. |
| `GET /api/tomes/:id` | One tome, full body. |
| `GET /api/resolve/:callNumber` | Shelf position, or 404. |

## Stack

Vite + TypeScript, no framework. Anime.js. Cloudflare Pages + Pages Functions +
D1. Fonts self-hosted via Fontsource — no CDN calls at runtime.

## Run it

Node 20+. If `npm install` prints `allow-scripts`, esbuild and workerd need
theirs to fetch platform binaries:

```bash
npm install
npm approve-scripts esbuild && npm approve-scripts workerd && npm rebuild
```

Then:

```bash
npm run db:local
npm run dev
```

`npm run dev` runs Vite building into `dist/` on save *and* `wrangler pages dev`
serving it with the D1 binding, from one command. <http://127.0.0.1:8788>.

Vite alone will not do — every `/api` route would 404.

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
There are no keys or tokens in this repo.

Later deploys are just `npm run deploy`. Migrations stay deliberate: a new one
needs `npm run db:remote` before the deploy that depends on it.

If the deployed API 500s while local works, the D1 binding did not carry over —
check **Workers & Pages → arcanaeum → Settings → Bindings** for `DB`.

## The writing

Nine tomes in `content/`, as markdown with frontmatter. **Drafts, meant to be
replaced.** Edit the markdown, never the SQL:

```bash
npm run seed && npm run db:local
```

Citations are not declared by hand — a call number appearing in a tome's prose
*is* a citation from it, and the generator fails if one points nowhere.

**The unlock mechanic is lore, not access control.** Restricted tomes are hidden
from the listing; you reach one by noticing a call number in a tome you can
already read and typing it into the catalogue. `/api/resolve` is public and
unthrottled — anyone can enumerate call numbers and read every restricted body.
Nothing may go in a restricted tome that would matter if a stranger read it.

## Layout

```
content/          the tomes. Source of truth for the writing.
scripts/          build-seed.mjs (content → migration), dev.mjs (runs the stack)
migrations/       numbered, via `wrangler d1 migrations`
shared/           schools and call-number shapes, used by client and API
functions/api/    the three routes, file-routed by Pages
public/art/       painted sheets — NOT dist/, which is emptied every build
public/audio/     the library theme
src/screens/      boot, chamber, catalogue, reader
src/lib/          api, router, store, markdown, sound, rubrication
src/styles/       plain CSS, one file per screen
```

## Notes

**Anime.js over GSAP.** Anime is MIT and ~17 KB for what this needs — DOM
transforms and opacity on a handful of elements — while GSAP's weight and
licensing only start paying off at scrub-timelines and plugins nothing here
wants. The reader's leaf turn was ported from a GSAP implementation whose
easing curves are plain cubic-béziers, so they came across intact.

**Art.** `ASSETS.md` lists every plate the finished site wants, with dimensions
and subject, and what stands in procedurally until it exists. One supplied
sheet needs re-exporting with a real alpha channel; `ASSETS.md` explains why.

**Sound** is synthesised in Web Audio and never plays before a gesture. The
library theme has its own toggle, off by default — no autoplaying ambient track.
