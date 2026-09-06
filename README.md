# The Arcanaeum

A 90s-CD-ROM-styled web archive of the College of Winterhold library. Boot
sequence, a stone chamber with a well and a sealed gate, a bitmap catalogue,
and a bound reader. Fan work, set in the Elder Scrolls world; all the writing
is original.

Vite + TypeScript, no UI framework. Three.js for one scene and nothing else.
Cloudflare Pages, Pages Functions, and D1.

---

## Run it

Requires Node 20 or newer (built on 24).

```bash
npm install
```

npm 11 blocks package install scripts by default, and both esbuild and workerd
need theirs to fetch their platform binaries. If `npm install` prints
`allow-scripts`:

```bash
npm approve-scripts esbuild && npm approve-scripts workerd && npm rebuild
```

Then create the local database and fill it:

```bash
npm run db:local
```

And start everything:

```bash
npm run dev
```

That runs Vite building into `dist/` on every save and `wrangler pages dev`
serving `dist/` with the D1 binding attached, both from one command. The
archive is at <http://127.0.0.1:8788>.

Vite alone will not do: the screens would come up and every `/api` route would
404, because the API is Pages Functions and the data is in D1.

### On Windows

If `npm run dev` fails with *"npm.ps1 cannot be loaded because running scripts
is disabled"*, that is PowerShell's execution policy refusing npm's PowerShell
shim, not a problem with this project. Either use the `.cmd` shim:

```bash
npm.cmd run dev
```

or allow local scripts once, in PowerShell:

```bash
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

---

## Cloudflare, from a brand-new account

Nothing below assumes any prior setup. Run it in order, in the project root.

**1. Sign in.** Opens a browser for OAuth.

```bash
npx wrangler login
```

**2. Create the database.**

```bash
npx wrangler d1 create arcanaeum
```

It prints a `database_id`. Put it in `wrangler.toml`, replacing the one already
there:

```toml
[[d1_databases]]
binding = "DB"
database_name = "arcanaeum"
database_id = "PASTE-IT-HERE"
migrations_dir = "migrations"
```

**The `database_id` is not a secret.** It is an opaque account-scoped handle
and it is useless to anyone without your Cloudflare credentials. It is
committed on purpose so the repo works after a plain `git clone`. Cloudflare
documents it as safe to commit. Nothing else in this repo is sensitive: there
are no keys, no tokens, and no `.dev.vars`.

**3. Apply the migrations locally**, and check it works before touching the
remote:

```bash
npx wrangler d1 migrations apply arcanaeum --local
npm run dev
```

**4. Apply them to the remote database.**

```bash
npx wrangler d1 migrations apply arcanaeum --remote
```

**5. Deploy.** The first run creates the Pages project, named `arcanaeum` after
`wrangler.toml`.

```bash
npm run deploy
```

That builds and then runs `wrangler pages deploy`, which reads
`pages_build_output_dir` and the D1 binding out of `wrangler.toml`. If the
deployed site's API returns 500 while local works, the binding did not carry
over — check **Workers & Pages → arcanaeum → Settings → Bindings** in the
dashboard for a D1 binding named `DB`, and add it there if it is missing.

### Later deploys

```bash
npm run deploy
```

Migrations are separate and deliberate. A new one has to be applied with
`npm run db:remote` before the deploy that needs it.

---

## The writing

The nine tomes live in `content/` as markdown with frontmatter — they are
**drafts, meant to be replaced**. Edit the markdown, never the SQL:

```bash
npm run seed
npm run db:local
```

`npm run seed` regenerates `migrations/0002_seed_content.sql` from `content/`.
Citations are not declared by hand: any call number appearing in a tome's prose
is a citation from it, and the generator fails the build if one points at a
volume that does not exist, because a dead end in the unlock mechanic reads as
a bug rather than as mystery.

For a change to reach production, the regenerated migration has to be applied
remotely too — or, if you would rather not re-run a migration that deletes and
re-inserts everything, add a new numbered migration instead.

### The unlock mechanic

Restricted tomes are hidden from the catalogue listing. The only way to one is
to notice a call number cited inside a tome you can already read and type it
into the catalogue's search field.

**This is lore, not access control.** `/api/resolve/:callNumber` is public,
unauthenticated and unthrottled; anyone can enumerate call numbers and read
every restricted body. Nothing may go in a restricted tome that would matter if
a stranger read it. The resolve handler says so at the top, and it is worth
saying twice.

---

## Layout

```
content/            the tomes, as markdown. The source of truth for the writing.
scripts/            build-seed.mjs turns content/ into a migration; dev.mjs runs the stack
migrations/         numbered, applied with `wrangler d1 migrations`
shared/             schools list and call-number shapes, imported by client and API
functions/api/      the three read-only routes, file-routed by Pages
public/art/         the painted sheets
public/audio/       the library theme
src/screens/        boot, chamber, catalogue, reader
src/lib/            api, router, store, markdown, sound, rubrication
src/styles/         plain CSS, one file per screen
```

The API is read-only. There is no `POST` route, no login, no admin, and no
analytics. Anything that is not a `GET` gets a 405.

## Notes

**Anime.js over GSAP.** Anime is MIT and about 17 KB for what this needs, which
is DOM transforms and opacity on a handful of elements — GSAP's weight and
licensing only start paying for themselves at scrub-timelines and plugins that
nothing here wants. The reader's leaf turn was ported from a GSAP
implementation and its easing curves are plain cubic-béziers, so they came
across as `cubicBezier(...)` with nothing lost.

**Three.js is code-split.** It is a dynamic import in `src/main.ts` and lands
in its own ~528 KB chunk. Reduced-motion visitors, and anyone going straight to
the catalogue, never download a byte of it. Keep it that way: importing
anything from `three` outside `src/screens/chamber.ts` pulls it into the main
bundle.

**The chamber is skipped entirely under `prefers-reduced-motion`,** which lands
on the catalogue. The boot sequence runs once per browser and is skippable on
any key.

**Placeholders.** Every image the site wants is listed in `ASSETS.md` with its
dimensions and subject. Until they are painted, the site draws procedural
stand-ins. One supplied sheet needs re-exporting — `ASSETS.md` explains why.
