-- Migration 0021 — the 49 books lying within the Arcanaeum, flagged readable elsewhere.
-- Source: Book_Index, Location = Arcanaeum; 49 register rows folded to 41 catalogue works.
-- A guest may emote picking these up and read them on an approved external source;
-- the College does not hand them over, so they read blue, not green.
UPDATE tomes SET readable_online = 1 WHERE call_number IN (
  'AR-I-001','AR-I-003',
  'AR-II-003','AR-II-006','AR-II-007',
  'AR-III-004','AR-III-008','AR-III-009','AR-III-020',
  'AR-IV-011','AR-IV-030','AR-IV-031','AR-IV-035','AR-IV-040','AR-IV-052',
  'AR-V-012','AR-V-018','AR-V-021','AR-V-028','AR-V-029','AR-V-031','AR-V-032','AR-V-046','AR-V-050',
  'AR-VI-014',
  'AR-VII-006',
  'AR-VIII-012','AR-VIII-017','AR-VIII-021',
  'AR-IX-003',
  'AR-X-003','AR-X-014','AR-X-020','AR-X-022','AR-X-030','AR-X-036',
  'AR-XI-003','AR-XI-004','AR-XI-005','AR-XI-008','AR-XI-009'
);