-- Migration 0022
-- The live Restricted Titles register now contains exactly two sealed titles:
-- A Kiss, Sweet Mother and Liminal Bridges.
-- Clear stale restricted flags left by the previous eight-title catalogue.
--
-- This changes catalogue metadata only. It is not an authorization boundary.

UPDATE tomes
SET restricted = 0
WHERE title IN (
  'A Tragedy in Black',
  'Brothers of Darkness',
  'Liminal Bridges: Simplified',
  'Mannimarco, King of Worms',
  'Souls, Black and White',
  'The Doors of Oblivion'
);

UPDATE tomes
SET restricted = 1
WHERE title IN (
  'A Kiss, Sweet Mother',
  'Liminal Bridges'
);
