BEGIN;

-- ---------- Organizations (LNGOs + a couple of INGOs; mix of registered/unregistered) ----------
INSERT INTO inso.organization (org_name, partner_type_id, partner_status_id, external_org_code) VALUES
('Kaalo Aid and Development',              (SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'KAALO-SO'),
('Sahan Relief & Development',             (SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'SAHAN-SO'),
('Hodan Women Organization',               (SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'HWO-001'),
('Banadir Health Network',                 (SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'BHN-BA'),
('Jubaland Community Initiative',          (SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Unregistered'), 'JCI-XX'),
('Galmudug Youth Council',                 (SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Unregistered'), 'GYC-XX'),
('Baidoa Relief & Development Organization',(SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'), (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'BRDO-BY'),
('Puntland Social Dev. Association (PSDA)',(SELECT partner_type_id FROM inso.partner_type WHERE name='LNGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'PSDA-PL'),
('Norwegian Refugee Council (NRC)',        (SELECT partner_type_id FROM inso.partner_type WHERE name='INGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'NRC-INT'),
('Concern Worldwide',                      (SELECT partner_type_id FROM inso.partner_type WHERE name='INGO'),  (SELECT partner_status_id FROM inso.partner_status WHERE name='Registered'),   'CONCERN-INT');

-- ---------- Focal persons (app users) ----------
INSERT INTO inso.app_user (full_name, email) VALUES
('Ayaan Isse',        'focal.hargeisa@inso.org'),
('Mohamed Ali',       'focal.mogadishu@inso.org'),
('Sagal Abdi',        'focal.garowe@inso.org');

-- ---------- Participants (Somali names, roles, phones, orgs, home cities) ----------
INSERT INTO inso.participant (full_name, phone, job_title, org_id, home_location_id) VALUES
('Ali Ahmed',        '+252634412110', 'Security Officer',   (SELECT org_id FROM inso.organization WHERE org_name='Kaalo Aid and Development'),              (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Mohamed Hassan',   '+252614412111', 'Program Officer',    (SELECT org_id FROM inso.organization WHERE org_name='Sahan Relief & Development'),            (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Aisha Fadumo',     '+252654412112', 'IM Officer',         (SELECT org_id FROM inso.organization WHERE org_name='Hodan Women Organization'),             (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Hawa Abdi',        '+252634412113', 'Field Coordinator',  (SELECT org_id FROM inso.organization WHERE org_name='Banadir Health Network'),               (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Maryan Ismail',    '+252614412114', 'Analyst',            (SELECT org_id FROM inso.organization WHERE org_name='Jubaland Community Initiative'),        (SELECT location_id FROM inso.location WHERE city_name='Kismayo')),
('Anisa Warsame',    '+252654412115', 'Program Manager',    (SELECT org_id FROM inso.organization WHERE org_name='Galmudug Youth Council'),               (SELECT location_id FROM inso.location WHERE city_name='Beletweyne')),
('Abdullahi Mohamed','+252634412116', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Baidoa Relief & Development Organization'),(SELECT location_id FROM inso.location WHERE city_name='Baidoa')),
('Fartun Ali',       '+252614412117', 'Coordinator',        (SELECT org_id FROM inso.organization WHERE org_name='Puntland Social Dev. Association (PSDA)'),(SELECT location_id FROM inso.location WHERE city_name='Garowe')),
('Nimco Farah',      '+252654412118', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Norwegian Refugee Council (NRC)'),      (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Hodan Mohamed',    '+252634412119', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Concern Worldwide'),                    (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Sahra Ahmed',      '+252614412120', 'Security Assistant', (SELECT org_id FROM inso.organization WHERE org_name='Kaalo Aid and Development'),             (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Khadar Hassan',    '+252654412121', 'Liaison',            (SELECT org_id FROM inso.organization WHERE org_name='Sahan Relief & Development'),            (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Liban Yusuf',      '+252634412122', 'Analyst',            (SELECT org_id FROM inso.organization WHERE org_name='Hodan Women Organization'),             (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Jamal Abdullahi',  '+252614412123', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Banadir Health Network'),               (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Ahmed Omar',       '+252654412124', 'Coordinator',        (SELECT org_id FROM inso.organization WHERE org_name='Jubaland Community Initiative'),        (SELECT location_id FROM inso.location WHERE city_name='Kismayo')),
('Yasmin Abdullahi', '+252634412125', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Galmudug Youth Council'),               (SELECT location_id FROM inso.location WHERE city_name='Beletweyne')),
('Ikran Mohamed',    '+252614412126', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Baidoa Relief & Development Organization'),(SELECT location_id FROM inso.location WHERE city_name='Baidoa')),
('Muna Ali',         '+252654412127', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Puntland Social Dev. Association (PSDA)'),(SELECT location_id FROM inso.location WHERE city_name='Garowe')),
('Bilal Hussein',    '+252634412128', 'Program Officer',    (SELECT org_id FROM inso.organization WHERE org_name='Norwegian Refugee Council (NRC)'),      (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Halima Mohamed',   '+252614412129', 'Security Officer',   (SELECT org_id FROM inso.organization WHERE org_name='Concern Worldwide'),                    (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Farah Isse',       '+252654412130', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Kaalo Aid and Development'),             (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Rahma Abdullahi',  '+252634412131', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Sahan Relief & Development'),            (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Mahad Abdi',       '+252614412132', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Hodan Women Organization'),             (SELECT location_id FROM inso.location WHERE city_name='Hargeisa')),
('Amina Mohamed',    '+252654412133', 'Coordinator',        (SELECT org_id FROM inso.organization WHERE org_name='Banadir Health Network'),               (SELECT location_id FROM inso.location WHERE city_name='Mogadishu')),
('Deeqo Yusuf',      '+252634412134', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Jubaland Community Initiative'),        (SELECT location_id FROM inso.location WHERE city_name='Kismayo')),
('Ruqiya Hassan',    '+252614412135', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Galmudug Youth Council'),               (SELECT location_id FROM inso.location WHERE city_name='Beletweyne')),
('Bashir Ali',       '+252654412136', 'Officer',            (SELECT org_id FROM inso.organization WHERE org_name='Baidoa Relief & Development Organization'),(SELECT location_id FROM inso.location WHERE city_name='Baidoa'));

-- ---------- Events (Sep 2025). SR = bi-weekly in Mogadishu/Hargeisa/Garowe; Orientation = bi-monthly; CD Briefing = monthly ----------
INSERT INTO inso.event (event_date, location_id, meeting_type_id, period_type_id, created_by) VALUES
('2025-09-05', (SELECT location_id FROM inso.location WHERE city_name='Mogadishu'), (SELECT meeting_type_id FROM inso.meeting_type WHERE name='Security Roundtable'),      (SELECT period_type_id FROM inso.period_type WHERE name='bi-weekly'),  (SELECT user_id FROM inso.app_user WHERE email='focal.mogadishu@inso.org')),
('2025-09-06', (SELECT location_id FROM inso.location WHERE city_name='Hargeisa'),  (SELECT meeting_type_id FROM inso.meeting_type WHERE name='Security Roundtable'),      (SELECT period_type_id FROM inso.period_type WHERE name='bi-weekly'),  (SELECT user_id FROM inso.app_user WHERE email='focal.hargeisa@inso.org')),
('2025-09-07', (SELECT location_id FROM inso.location WHERE city_name='Garowe'),    (SELECT meeting_type_id FROM inso.meeting_type WHERE name='Security Roundtable'),      (SELECT period_type_id FROM inso.period_type WHERE name='bi-weekly'),  (SELECT user_id FROM inso.app_user WHERE email='focal.garowe@inso.org')),
('2025-09-08', (SELECT location_id FROM inso.location WHERE city_name='Baidoa'),    (SELECT meeting_type_id FROM inso.meeting_type WHERE name='Orientation Briefing'),     (SELECT period_type_id FROM inso.period_type WHERE name='bi-monthly'), (SELECT user_id FROM inso.app_user WHERE email='focal.hargeisa@inso.org')),
('2025-09-10', (SELECT location_id FROM inso.location WHERE city_name='Mogadishu'), (SELECT meeting_type_id FROM inso.meeting_type WHERE name='Country Directors Briefing'),(SELECT period_type_id FROM inso.period_type WHERE name='monthly'),    (SELECT user_id FROM inso.app_user WHERE email='focal.mogadishu@inso.org'));

-- ---------- Submissions (all events get a final submission 5 days later) ----------
INSERT INTO inso.submission (event_id, submitted_by, submitted_at, is_final)
SELECT e.event_id, (SELECT user_id FROM inso.app_user WHERE email='focal.mogadishu@inso.org'), e.event_date + INTERVAL '5 days', TRUE
FROM inso.event e
WHERE e.event_date BETWEEN DATE '2025-09-05' AND DATE '2025-09-10';

-- ---------- Uploads (attendance, slides, minutes) for each submission ----------
INSERT INTO inso.upload (submission_id, required_doc_type_id, filename, file_url, mime_type, file_size_bytes, checksum_sha256, uploaded_at)
SELECT s.submission_id, r.required_doc_type_id,
       'EVT-'||s.event_id||'-'||r.code||'.pdf',
       'https://files.inso.local/EVT-'||s.event_id||'/'||r.code||'.pdf',
       'application/pdf', 125000, NULL, s.submitted_at
FROM inso.submission s
JOIN (SELECT required_doc_type_id, code FROM inso.required_doc_type WHERE code IN ('ATTENDANCE','SLIDES','MINUTES')) r ON TRUE;

-- ---------- Attendance (Security RT ~12; Orientation ~12; CD Briefing ~22) ----------
-- Mogadishu Security Roundtable (2025-09-05)
INSERT INTO inso.attendance (event_id, participant_id, role_at_event)
SELECT e.event_id, p.participant_id, 'Attendee'
FROM inso.event e
JOIN inso.participant p ON p.full_name IN ('Ali Ahmed','Mohamed Hassan','Hawa Abdi','Maryan Ismail','Anisa Warsame','Abdullahi Mohamed','Fartun Ali','Nimco Farah','Jamal Abdullahi','Ahmed Omar','Hassan Abdulle','Fatima Ahmed')
WHERE e.event_date=DATE '2025-09-05'
  AND e.location_id=(SELECT location_id FROM inso.location WHERE city_name='Mogadishu')
  AND e.meeting_type_id=(SELECT meeting_type_id FROM inso.meeting_type WHERE name='Security Roundtable');

-- Hargeisa Security Roundtable (2025-09-06)
INSERT INTO inso.attendance (event_id, participant_id, role_at_event)
SELECT e.event_id, p.participant_id, 'Attendee'
FROM inso.event e
JOIN inso.participant p ON p.full_name IN ('Aisha Fadumo','Hodan Mohamed','Sahra Ahmed','Khadar Hassan','Liban Yusuf','Yasmin Abdullahi','Ikran Mohamed','Muna Ali','Bilal Hussein','Halima Mohamed','Farah Isse','Rahma Abdullahi')
WHERE e.event_date=DATE '2025-09-06'
  AND e.location_id=(SELECT location_id FROM inso.location WHERE city_name='Hargeisa')
  AND e.meeting_type_id=(SELECT meeting_type_id FROM inso.meeting_type WHERE name='Security Roundtable');

-- Garowe Security Roundtable (2025-09-07)
INSERT INTO inso.attendance (event_id, participant_id, role_at_event)
SELECT e.event_id, p.participant_id, 'Attendee'
FROM inso.event e
JOIN inso.participant p ON p.full_name IN ('Mahad Abdi','Amina Mohamed','Deeqo Yusuf','Ruqiya Hassan','Bashir Ali','Ali Ahmed','Mohamed Hassan','Hawa Abdi','Maryan Ismail','Anisa Warsame','Ahmed Omar')
WHERE e.event_date=DATE '2025-09-07'
  AND e.location_id=(SELECT location_id FROM inso.location WHERE city_name='Garowe')
  AND e.meeting_type_id=(SELECT meeting_type_id FROM inso.meeting_type WHERE name='Security Roundtable');

-- Baidoa Orientation Briefing (2025-09-08)
INSERT INTO inso.attendance (event_id, participant_id, role_at_event)
SELECT e.event_id, p.participant_id, 'Attendee'
FROM inso.event e
JOIN inso.participant p ON p.full_name IN ('Fartun Ali','Nimco Farah','Hodan Mohamed','Sahra Ahmed','Khadar Hassan','Liban Yusuf','Yasmin Abdullahi','Ikran Mohamed','Muna Ali','Bilal Hussein','Halima Mohamed','Farah Isse')
WHERE e.event_date=DATE '2025-09-08'
  AND e.location_id=(SELECT location_id FROM inso.location WHERE city_name='Baidoa')
  AND e.meeting_type_id=(SELECT meeting_type_id FROM inso.meeting_type WHERE name='Orientation Briefing');

-- Mogadishu Country Directors Briefing (2025-09-10)
INSERT INTO inso.attendance (event_id, participant_id, role_at_event)
SELECT e.event_id, p.participant_id, 'Attendee'
FROM inso.event e
JOIN inso.participant p ON p.full_name IN ('Ali Ahmed','Mohamed Hassan','Aisha Fadumo','Hawa Abdi','Maryan Ismail','Anisa Warsame','Abdullahi Mohamed','Fartun Ali','Nimco Farah','Hodan Mohamed','Sahra Ahmed','Khadar Hassan','Liban Yusuf','Jamal Abdullahi','Ahmed Omar','Yasmin Abdullahi','Ikran Mohamed','Muna Ali','Bilal Hussein','Halima Mohamed','Farah Isse','Rahma Abdullahi')
WHERE e.event_date=DATE '2025-09-10'
  AND e.location_id=(SELECT location_id FROM inso.location WHERE city_name='Mogadishu')
  AND e.meeting_type_id=(SELECT meeting_type_id FROM inso.meeting_type WHERE name='Country Directors Briefing');

COMMIT;
