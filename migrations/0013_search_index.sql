-- Migration 0013 — the search index, and the one index the citations table
-- has always needed.
--
-- NOT GENERATED. Unlike the shelf migrations this file is written by hand and
-- is a real, append-only migration.
--
-- Until now the catalogue could only search what it had already downloaded —
-- call number, title, author, shelf — because /api/tomes deliberately never
-- selects `body`. A librarian asking for "illusion" wants every book that
-- CONTAINS the word, not the handful with it in the title, and the prose is not
-- on the client at any price. So the search moves to the database.

-- External-content FTS5: the index stores terms and offsets, and the text stays
-- in `tomes`. It halves what would otherwise be a second copy of 1.7 MB of
-- prose, and `content_rowid = id` lets a hit join straight back to its book.
CREATE VIRTUAL TABLE tomes_fts USING fts5(
  title,
  author,
  body,
  content='tomes',
  content_rowid='id',
  tokenize='unicode61 remove_diacritics 2'
);

-- Populate from the rows the shelf migrations inserted. An external-content
-- table is empty until it is told to read its source.
INSERT INTO tomes_fts(tomes_fts) VALUES('rebuild');

-- The shelf migrations rewrite the corpus wholesale rather than editing rows,
-- so the index is rebuilt with them rather than maintained by triggers. If
-- single-row edits ever arrive, that is when the three triggers are worth
-- adding — not before.

-- `citations` has been written by the seed and selected by nothing since it was
-- created. The reader is about to select from it by the cited call number, on
-- every book it opens.
CREATE INDEX idx_citations_cites ON citations(cites_call_number);
