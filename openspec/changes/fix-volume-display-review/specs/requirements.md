## Requirements

### Requirement: preserve volume metadata in the public tome summary

The system SHALL return a TomeSummary object for every non-restricted catalogue row that can carry a volume label without losing the title metadata in the summary API shape.

#### Scenario: catalogue row includes a title and an attachable volume label
- WHEN the catalogue loads the `listTomes()` panel in the app
- THEN each open shelf row SHALL render the same call-number, title, author, and metadata formatting that is already visible in the reader and the frontmatter contents

### Requirement: catalogue needs deterministic entry rendering

The application SHALL generate a deterministic catalogue row set from the markdown `content/` files and the `scripts/build-seed.mjs` generator.

#### Scenario: generator sees content frontmatter
- WHEN the project rebuilds the seeded content from markdown
- THEN the generated SQL MUST preserve the `title`, `author`, `school`, `call_number`, and any attached per-volume metadata without stripping fields from the parser.

### Requirement: review symptoms must be visible as testable acceptance scenarios

The application SHALL have a recorded change plan that specifically notes the examples reported by users:

- `Songs of the Return` must show a volume marker.
- `2920` rows must retain their row formatting instead of manufacturing a malformed or shadowed row number.
- `Lusty Argonian Maid` must show a volume label in the same rendering path as other catalogue rows.
