-- Migration 0020
-- Reset externally-readable flags populated by the incorrect 0019 data pass.
-- The authoritative ~49-title list will be populated separately.

UPDATE tomes SET readable_online = 0;
