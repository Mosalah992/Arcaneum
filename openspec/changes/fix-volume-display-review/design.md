# Design

The fix should be implemented in the source of truth for content generation, then propagated to the generated seed and the client-side summary interface.

The idea is:

1. Treat the markdown content files in `content/` as the upstream of truth.
2. Regenerate the database seed using `scripts/build-seed.mjs` so the SQL file reflects the corrected parser metadata.
3. Ensure the TypeScript list endpoint schema (`src/lib/api.ts`, `functions/api/tomes/index.ts`) and rendering path (`src/screens/catalogue.ts`, `src/screens/reader.ts`) do not drop a `volume` field when a row is rendered.
4. Keep the review examples in the acceptance notes and verify the row metadata in the UI.
