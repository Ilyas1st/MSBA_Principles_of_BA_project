-- List all partner organizations 
SELECT * FROM inso.organization;

-- All events with their city and meeting type
SELECT e.event_id, e.event_date, l.city_name, mt.name AS meeting_type
FROM inso.event e
JOIN inso.location l      ON l.location_id = e.location_id
JOIN inso.meeting_type mt ON mt.meeting_type_id = e.meeting_type_id;

-- Submissions joined to their events 
SELECT s.submission_id, e.event_id, e.event_date, s.is_final
FROM inso.submission s
JOIN inso.event e ON e.event_id = s.event_id;

-- Full names of participants whose organizations are LNGOs
SELECT p.full_name
FROM inso.participant p
JOIN inso.organization o   ON o.org_id = p.org_id
JOIN inso.partner_type pt  ON pt.partner_type_id = o.partner_type_id
WHERE pt.name = 'LNGO';

-- Event IDs and dates of Security Roundtable events that are bi-weekly
SELECT e.event_id, e.event_date
FROM inso.event e
JOIN inso.meeting_type mt ON mt.meeting_type_id = e.meeting_type_id
JOIN inso.period_type  pt ON pt.period_type_id  = e.period_type_id
WHERE mt.name = 'Security Roundtable'
  AND pt.name = 'bi-weekly';

-- Submission and filenames for Mogadishu Country Directors Briefing on 2025-09-10
SELECT s.submission_id, u.filename
FROM inso.event e
JOIN inso.location l ON l.location_id = e.location_id
JOIN inso.submission s ON s.event_id = e.event_id
JOIN inso.upload u     ON u.submission_id = s.submission_id
JOIN inso.meeting_type mt ON mt.meeting_type_id = e.meeting_type_id
WHERE l.city_name = 'Mogadishu'
  AND mt.name = 'Country Directors Briefing'
  AND e.event_date = DATE '2025-09-10';

-- Top Attendees
SELECT
  p.full_name,
  COUNT(*)              AS events_attended,
  MIN(e.event_date)     AS first_attended,
  MAX(e.event_date)     AS last_attended
FROM inso.attendance a
JOIN inso.participant p ON p.participant_id = a.participant_id
JOIN inso.event e       ON e.event_id = a.event_id
GROUP BY p.full_name
ORDER BY events_attended DESC, last_attended DESC, p.full_name
LIMIT 5;  

--Security Roundtable reach by city per partner type
WITH sr AS (
  SELECT a.participant_id, e.location_id
  FROM inso.attendance a
  JOIN inso.event e      ON e.event_id = a.event_id
  JOIN inso.meeting_type mt ON mt.meeting_type_id = e.meeting_type_id
  WHERE mt.name = 'Security Roundtable'
),
mix AS (
  SELECT
    l.city_name,
    COALESCE(pt.name, 'Unknown type') AS partner_type,
    COUNT(DISTINCT p.participant_id)  AS participants,
    COUNT(DISTINCT o.org_id)          AS orgs
  FROM sr
  JOIN inso.participant p ON p.participant_id = sr.participant_id
  LEFT JOIN inso.organization o ON o.org_id = p.org_id
  LEFT JOIN inso.partner_type pt ON pt.partner_type_id = o.partner_type_id
  JOIN inso.location l ON l.location_id = sr.location_id
  GROUP BY l.city_name, pt.name
)
SELECT
  m.city_name,
  m.partner_type,
  m.orgs,
  m.participants,
  -- share of orgs within the city (kept simple; no window functions needed)
  ROUND(100.0 * m.orgs / NULLIF((
      SELECT SUM(orgs) FROM mix WHERE city_name = m.city_name
  ),0), 1) AS pct_orgs_in_city
FROM mix m
ORDER BY m.city_name, m.partner_type;

-- Distinct organization names that attended a Security Roundtable
SELECT DISTINCT o.org_name
FROM inso.attendance a
JOIN inso.event e         ON e.event_id = a.event_id
JOIN inso.meeting_type mt ON mt.meeting_type_id = e.meeting_type_id
JOIN inso.participant p   ON p.participant_id = a.participant_id
JOIN inso.organization o  ON o.org_id = p.org_id
WHERE mt.name = 'Security Roundtable';

-- Maximum and minimum attendance (only events with some attendance)
SELECT
  MAX(att_count) AS max_attendance,
  MIN(att_count) AS min_attendance
FROM (
  SELECT e.event_id, COUNT(a.participant_id) AS att_count
  FROM inso.event e
  JOIN inso.attendance a ON a.event_id = e.event_id
  GROUP BY e.event_id
) AS event_attendance;

-- Highest attendance event(s) for each meeting type 
SELECT meeting_type, event_id, event_date, att_count
FROM (
  SELECT
    mt.name AS meeting_type,
    e.event_id,
    e.event_date,
    COUNT(a.participant_id) AS att_count,
    RANK() OVER (PARTITION BY mt.name ORDER BY COUNT(a.participant_id) DESC) AS rnk
  FROM inso.event e
  JOIN inso.meeting_type mt ON mt.meeting_type_id = e.meeting_type_id
  LEFT JOIN inso.attendance a ON a.event_id = e.event_id
  GROUP BY mt.name, e.event_id, e.event_date
) t
WHERE rnk = 1
ORDER BY meeting_type, event_date;

