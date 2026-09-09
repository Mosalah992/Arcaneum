-- The register of consultation: how many readers have consulted the archive.
--
-- ONE ROW AND ONE INTEGER. There is no row per visitor, no address, no user
-- agent, no timestamp and no country — there is deliberately nothing here that
-- could answer "did this person come back", or "where from". The Thalmor
-- archive's version of this table keeps a per-country tally; this one does not,
-- because the brief for this counter was the number and nothing else.
--
-- The single row is pinned by the CHECK: there can only ever be one, so no code
-- has to decide which row is the real one.

CREATE TABLE IF NOT EXISTS tally (
  id     INTEGER PRIMARY KEY CHECK (id = 1),
  visits INTEGER NOT NULL DEFAULT 0
);

-- Starts at nought, and says so. The footer showed 0041982 for months and it
-- was a decoration; a real counter that opens on a borrowed number would be a
-- worse thing than the decoration was, because it would look true.
INSERT OR IGNORE INTO tally (id, visits) VALUES (1, 0);
