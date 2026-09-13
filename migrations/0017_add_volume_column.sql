-- Migration 0017 — add backfillable volume metadata for volume-aware catalogue rows.

ALTER TABLE tomes ADD COLUMN volume TEXT NOT NULL DEFAULT '';
