# Proposal

We need the catalogue and reader title-page surfaces to show the volume metadata reliably for the reviewed content examples, including `Songs of the Return`, the `2920` numbering pattern, and `Lusty Argonian Maid`. The underlying issue appears to originate in the generated seed path and the summary metadata shape carried from API list endpoints into the catalogue rendering path.

## Why

The user reviews describe three visible regressions:

- `Songs of the Return` does not show its volume label.
- A `2920` entry is rendered as an odd-looking row that appears to show a malformed or missing volume marker.
- `Lusty Argonian Maid` does not show volumes.

The fix should be grounded in the repository's content markdown source and the seed generator rather than by manually editing the SQL migration.
