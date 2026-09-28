# Arcanaeum — Codex project brief

This is the working reference for coding agents in this repository. It records what the checked-in project does and the user-provided architecture direction. Verify details in source before relying on this note; update it when durable project facts change.

## Project

The Arcanaeum is a browser-based, 1990s CD-ROM-styled archive and catalogue of books from *The Elder Scrolls V: Skyrim*, with full-text search and College of Winterhold holdings information. It is a non-profit accessibility project for role-play communities. The book text is Bethesda's; the README credits the Library of Skyrim transcription. The live site listed by the README is <https://arcanaeum.pages.dev>. The user-provided project repository is <https://github.com/mosalah992/arcaneum>.

The interface presents an insert-disc entry screen and a searchable catalogue. The current implementation is plain DOM and CSS with a small Anime.js animation dependency; it is not a component framework or 3D application. Preserve the established visual language, keyboard behavior, accessibility, reduced-motion behavior, and self-hosted fonts when implementing frontend work.

## Verified stack and deployment

- TypeScript, native browser DOM APIs, CSS, Vite 8, Anime.js 4, and self-hosted Fontsource assets.
- Cloudflare Pages hosts the static Vite output (`dist`) and `functions/` Pages Functions.
- Cloudflare D1 is bound as `DB`; SQL schema and incremental data changes live in `migrations/`.
- SQLite FTS5 backs server-side full-text search. Keep book bodies in D1 and out of catalogue-list responses.
- `shared/` contains TypeScript used across client and functions (for example shelf definitions and calendar logic).
- `content/library/` contains the source book markdown; `content/` also contains catalogue metadata. `scripts/` builds/imports seed data and manages local data tasks.
- College holdings are read from Google Sheets by the server-side integration in `functions/lib/availability.ts`. The Sheets integration is optional and returns an unconfigured/unavailable answer without preventing the catalogue from loading.
- Do not add a framework, ORM, database, or hosted dependency without a concrete need and a documented decision. Keep secrets in Cloudflare environment configuration or ignored local `.dev.vars`; never commit them.

## Runtime and connections

```text
Browser
  src/main.ts -> hash router -> insert/catalogue screens
  src/lib/api.ts -> same-origin /api/* requests
                                |
Cloudflare Pages Functions      |
  functions/api/_middleware.ts guards API routes (except /api/gate)
       |                        |
       +--> D1 (DB): catalogue metadata, bodies, FTS5, visit tally
       +--> Google Sheets: optional College holdings register
```

The user's attached diagram is architecture context: reader -> disc entry -> hash router -> catalogue -> API client; API endpoints serve the gate, tome listing, search, call-number resolution, holdings, and visits. It also depicts a book corpus feeding D1 and Google Sheets as the external register. Use it as a map of intended responsibilities, and verify current filenames/contracts against the source before editing. It is not an instruction to reproduce every box if the current implementation differs.

### API map

| Endpoint | Purpose and backing service |
| --- | --- |
| `GET /api/gate`, `POST /api/gate` | Gate status and passphrase exchange; public so readers can obtain a signed admission cookie. |
| `GET /api/tomes?shelf=...` | Catalogue metadata from D1; deliberately excludes book bodies. |
| `GET /api/search?q=...&shelf=...` | FTS5-backed body search in D1. Search is debounced and abortable in the client. |
| `GET /api/resolve/:callNumber` | Resolve a call number to catalogue metadata in D1. |
| `GET /api/availability` | Read holdings from Google Sheets using service-account credentials. |
| `GET /api/register` | Read the visit tally from D1. |
| `POST /api/register/entry` | Idempotently record an admitted reader using a daily cookie and D1. |

`src/lib/api.ts` also defines `fetchTome(id)` for `GET /api/tomes/:id`, but the current `functions/api/tomes/` tree only contains `index.ts`. Treat this as an implementation gap: do not build a feature that depends on tome-detail retrieval until the endpoint is added or the client wrapper is removed. Recheck the tree because this note can become stale.

### Gate and cache boundaries

- `functions/api/_middleware.ts` protects API routes other than `/api/gate`. The gate screen is UI; middleware is the access-control boundary.
- Admission uses `ARCANAEUM_PASSPHRASE` to validate the shared word and a separate `ARCANAEUM_GATE_SECRET` to sign the `arcanaeum_writ` cookie. Keep these secrets distinct and server-side.
- Gate status/entry must remain available before admission. Never expose secrets to Vite/client code.
- Protected responses must not be served from a shared cache. Respect middleware cache rewriting and the response cache policy when adding routes.
- The Sheets service account JSON and spreadsheet ID (`GOOGLE_SERVICE_ACCOUNT_JSON`, `ARCANAEUM_SHEET_ID`) are server-side optional bindings. Do not let register failures block core catalogue functions.

## Frontend and API implementation guidance

- Trace a feature through screen -> `src/lib/api.ts` -> Pages Function -> service/data. Keep request/response types aligned at both ends.
- Use the existing DOM helpers and screen lifecycle (`destroy`) so listeners, timers, and in-flight requests are cleaned up. Abort superseded search work.
- Keep book bodies off listing responses; use the search endpoint for body queries. Bind SQL parameters; do not interpolate user input into SQL.
- Keep shelf/call-number vocabulary consistent with `shared/` and the D1 rows. Treat content markdown and generated/seed data as related inputs: follow the existing import/build scripts rather than editing generated state blindly.
- Keep graceful fallback behavior for offline API calls and unavailable Sheets. Do not make a nonessential integration a blocker for rendering the catalogue.
- Follow existing accessibility semantics: real links/buttons/labels, focus and keyboard behavior, visible status, and reduced-motion handling.
- Before changing an API or schema, inspect all callers and migrations. Add a forward migration for schema changes; do not rewrite already-applied migrations to express a new production change.

## Useful commands

- `npm run dev` — local Vite + Pages Functions workflow (`scripts/dev.mjs`).
- `npm run build` — TypeScript check followed by Vite production build.
- `npm run typecheck` — TypeScript only.
- `npm run db:local` — apply D1 migrations locally.
- `npm run seed` / `npm run import` — prepare/import library data; inspect scripts before running because they mutate local database state.
- `npm run deploy` — build and deploy Pages; deployment is an external action and requires explicit user direction.

Run checks when the user asks for verification or when they are necessary to safely complete a requested change. Avoid resetting or importing databases without checking the intended target and the script's effects.

## Persistent project memory

`knowledge/` is a normal Markdown folder and an Obsidian vault. Open that folder as a vault in Obsidian; notes remain plain files in this repository and can be reviewed/versioned with project changes. `AGENTS.md` is the Codex entry point and asks agents to read this brief and consult relevant vault notes. For durable work, record the decision or runbook in the smallest relevant note, link it to source files, and update this brief only when its summary or operating rules change. Avoid session transcripts and duplicated source documentation.

See [[knowledge/README]] for the vault map and [[knowledge/Architecture]] for the component and integration map.
