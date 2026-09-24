-- Migration 0018 — externally readable catalogue classification.
--
-- NOT GENERATED. A book may exist in the game world and be readable through an
-- approved external source (UESP and the like) with an RP emote, whether or not
-- the College holds a physical copy. That is a property of the catalogue entry,
-- not of the register: the register answers "do we own it / is it on the shelf
-- today"; this column answers "may a guest read it elsewhere".
--
-- The two must not be collapsed. A title can be held and readable, held and not,
-- unheld and readable, or neither. DEFAULT 0 keeps every existing row behaving
-- exactly as it did before this column existed.
--
-- Populating the flag is a data-entry step (frontmatter `readable_online: true`
-- and/or content/readable-online.json), not this migration.

ALTER TABLE tomes ADD COLUMN readable_online INTEGER NOT NULL DEFAULT 0;
