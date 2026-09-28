# Decisions and known gaps

Record durable changes here in reverse chronological order. Each entry should include the date, decision or finding, reason, and source links. Do not record secrets or temporary chat state.

## 2026-09-28 — Deployment account and local Wrangler dependencies

- If Wrangler cannot find `@cloudflare/workerd-windows-64`, restore the lockfile's platform dependencies with `npm ci --include=optional`, then rerun tests and the build.
- The repository's `wrangler.toml` references D1 database `9bbf2f7b-5813-43f2-9c82-cacfc9f6dde0`, which was unavailable in the logged-in Cloudflare account during deployment. That account's `arcanaeum` Pages project uses domain `arcanaeum-9z7.pages.dev`, different from the README's `arcanaeum.pages.dev`.
- The earlier successful deployment in that account bound `DB` to `151c0ae8-f91b-466f-89d3-e4ad97463f59`; inspection found only `_cf_KV` in that database and no Pages environment variables configured. Changing the binding alone would not produce a working archive. Confirm the intended account/site before changing bindings, initializing remote data, or configuring gate secrets.
- Historical ownership confirmed: September 13 Wrangler logs show successful D1 queries for the configured database under account `9a3688514d481cabc61a3ab29b7c02f5`, followed by successful deployments to `arcanaeum.pages.dev`. Use this account for the existing production database/site. The current OAuth credentials returned an authentication error when checking that account on September 28; authentication to the production account is required before deployment can continue.
- Source: [Wrangler configuration](../wrangler.toml); local Wrangler logs `wrangler-2026-09-13_06-08-01_049.log` (account), `wrangler-2026-09-13_06-11-56_003.log` (successful D1 queries), and `wrangler-2026-09-13_09-35-45_488.log` (successful Pages deployment). Historical evidence establishes the account used then; recheck live configuration after authentication.

## 2026-09-28 — Preserve cue-only sound after removing ambient music

- Ambient music was removed in commit `5615b63`, but unused track state and first-gesture calls to deleted music helpers remained. The same change removed `setMuted`, still required by the header SOUND toggle. Remove these remnants and restore the persisted mute setter while retaining gesture-gated synthesized cues.
- Regression tests exercise the actual sound and preference modules with browser audio/storage doubles. Run all repository tests with `npm test`, then `npm run build` before deployment.
- Keep Obsidian's changing workspace layout local; commit shared vault notes and settings.
- Source: [sound layer](../src/lib/sound.ts), [sound tests](../tests/sound.test.mjs).

## 2026-09-28 — Repository-local Obsidian memory

- Keep agent brief at root `codex.md`; `AGENTS.md` tells Codex to read it and the relevant notes under `knowledge/`.
- Keep the vault as plain Markdown inside this repository so the user owns it, can open it directly in Obsidian, and can version/share it with project work.
- Source: [AGENTS.md](../AGENTS.md), [codex.md](../codex.md), [vault map](README.md).

## 2026-09-28 — Tome detail route mismatch

- `src/lib/api.ts` exposes `fetchTome(id)` targeting `/api/tomes/:id`; the checked-in `functions/api/tomes/` directory currently has only `index.ts`. Verify before depending on the wrapper and resolve by implementing a matching handler or removing an unused wrapper.
- Source: [API client](../src/lib/api.ts), `functions/api/tomes/`.
