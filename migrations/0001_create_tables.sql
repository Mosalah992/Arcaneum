-- Migration 0001 — schema.
-- Two tables. The archive is a catalogue, not an application.

CREATE TABLE tomes (
  id           INTEGER PRIMARY KEY,
  call_number  TEXT NOT NULL UNIQUE,   -- e.g. "AR-IV-118"
  title        TEXT NOT NULL,
  author       TEXT NOT NULL,
  school       TEXT NOT NULL,          -- Destruction, Conjuration, Restoration,
                                       -- Illusion, Alteration, Alchemy, History, Daedra
  body         TEXT NOT NULL,          -- markdown
  restricted   INTEGER NOT NULL DEFAULT 0,
  created_at   TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE citations (
  id                INTEGER PRIMARY KEY,
  from_tome         INTEGER NOT NULL REFERENCES tomes(id),
  cites_call_number TEXT NOT NULL
);

CREATE INDEX idx_tomes_school ON tomes(school);
CREATE INDEX idx_tomes_restricted ON tomes(restricted);
CREATE INDEX idx_citations_from ON citations(from_tome);
