-- Create the schema and tables in a single code block
CREATE SCHEMA inso;

-- Master / Reference Tables

CREATE TABLE inso.location (
    location_id     SERIAL PRIMARY KEY,
    city_name       VARCHAR(40) NOT NULL UNIQUE
    -- e.g., Hargeisa, Mogadishu, Garowe, Kismayo, Baidoa, Bosaso, Beletweyne, Erigavo, Burco
);

CREATE TABLE inso.meeting_type (
    meeting_type_id SERIAL PRIMARY KEY,
    name            VARCHAR(60) NOT NULL UNIQUE
    -- e.g., Security Roundtable, Orientation Briefing, Country Directors Briefing
);

CREATE TABLE inso.period_type (
    period_type_id  SERIAL PRIMARY KEY,
    name            VARCHAR(20) NOT NULL UNIQUE
    -- expected values: weekly, bi-weekly, monthly, bi-monthly
);

CREATE TABLE inso.partner_type (
    partner_type_id SERIAL PRIMARY KEY,
    name            VARCHAR(20) NOT NULL UNIQUE
    -- LNGO, INGO, UN, Donor
);

CREATE TABLE inso.partner_status (
    partner_status_id SERIAL PRIMARY KEY,
    name              VARCHAR(20) NOT NULL UNIQUE
    -- Registered, Unregistered
);

-- Organizations & People

CREATE TABLE inso.organization (
    org_id            SERIAL PRIMARY KEY,
    org_name          VARCHAR(120) NOT NULL,
    partner_type_id   INT REFERENCES inso.partner_type (partner_type_id) ON DELETE SET NULL,
    partner_status_id INT REFERENCES inso.partner_status (partner_status_id) ON DELETE SET NULL,
    external_org_code VARCHAR(50),
    UNIQUE (org_name)
);

CREATE TABLE inso.participant (
    participant_id   SERIAL PRIMARY KEY,
    full_name        VARCHAR(120) NOT NULL,
    phone            VARCHAR(25),
    job_title        VARCHAR(80),
    org_id           INT REFERENCES inso.organization (org_id) ON DELETE SET NULL,
    home_location_id INT REFERENCES inso.location (location_id) ON DELETE SET NULL
);

CREATE TABLE inso.app_user (
    user_id   SERIAL PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    email     VARCHAR(120) NOT NULL UNIQUE
    -- focal persons entering data
);

-- Events and Attendance

CREATE TABLE inso.event (
    event_id        SERIAL PRIMARY KEY,
    event_date      DATE NOT NULL CHECK (event_date >= DATE '2015-01-01' AND event_date < DATE '2100-01-01'),
    location_id     INT NOT NULL REFERENCES inso.location (location_id) ON DELETE RESTRICT,
    meeting_type_id INT NOT NULL REFERENCES inso.meeting_type (meeting_type_id) ON DELETE RESTRICT,
    period_type_id  INT NOT NULL REFERENCES inso.period_type (period_type_id) ON DELETE RESTRICT,
    created_by      INT REFERENCES inso.app_user (user_id) ON DELETE SET NULL,
    created_at      TIMESTAMP DEFAULT now(),
    updated_at      TIMESTAMP DEFAULT now()
    -- optional future UNIQUE to prevent duplicates:
    -- UNIQUE (event_date, location_id, meeting_type_id)
);

-- Composite Primary Key 
CREATE TABLE inso.attendance (
    event_id       INT REFERENCES inso.event (event_id) ON DELETE CASCADE,
    participant_id INT REFERENCES inso.participant (participant_id) ON DELETE CASCADE,
    role_at_event  VARCHAR(30), -- Attendee, Speaker, Facilitator
    PRIMARY KEY (event_id, participant_id)
);


-- Document submissions

CREATE TABLE inso.required_doc_type (
    required_doc_type_id SERIAL PRIMARY KEY,
    code        VARCHAR(20) NOT NULL UNIQUE,  -- ATTENDANCE, SLIDES, MINUTES
    description VARCHAR(255)
);

CREATE TABLE inso.submission (
    submission_id SERIAL PRIMARY KEY,
    event_id      INT NOT NULL REFERENCES inso.event (event_id) ON DELETE CASCADE,
    submitted_by  INT REFERENCES inso.app_user (user_id) ON DELETE SET NULL,
    submitted_at  TIMESTAMP NOT NULL,
    is_final      BOOLEAN DEFAULT FALSE
);

CREATE TABLE inso.upload (
    upload_id            SERIAL PRIMARY KEY,
    submission_id        INT NOT NULL REFERENCES inso.submission (submission_id) ON DELETE CASCADE,
    required_doc_type_id INT NOT NULL REFERENCES inso.required_doc_type (required_doc_type_id) ON DELETE RESTRICT,
    filename             VARCHAR(255) NOT NULL,
    file_url             VARCHAR(500),
    mime_type            VARCHAR(100),
    file_size_bytes      BIGINT CHECK (file_size_bytes IS NULL OR file_size_bytes >= 0),
    checksum_sha256      VARCHAR(64),
    uploaded_at          TIMESTAMP DEFAULT now(),
    UNIQUE (submission_id, required_doc_type_id)  -- one of each required doc per submission
);


-- ingest and audit
CREATE TABLE inso.event_ingest_log (
    event_id        INT REFERENCES inso.event (event_id) ON DELETE CASCADE,
    source_filename VARCHAR(255),
    ingested_at     TIMESTAMP DEFAULT now(),
    PRIMARY KEY (event_id, source_filename)
);


-- Seed Reference Data (safe to re-run)

INSERT INTO inso.location (city_name) VALUES
('Hargeisa'),('Mogadishu'),('Garowe'),('Kismayo'),
('Baidoa'),('Bosaso'),('Beletweyne'),('Erigavo'),('Burco')
ON CONFLICT DO NOTHING;

INSERT INTO inso.meeting_type (name) VALUES
('Security Roundtable'),('Orientation Briefing'),('Country Directors Briefing')
ON CONFLICT DO NOTHING;

INSERT INTO inso.period_type (name) VALUES
('weekly'),('bi-weekly'),('monthly'),('bi-monthly')
ON CONFLICT DO NOTHING;

INSERT INTO inso.partner_type (name) VALUES
('LNGO'),('INGO'),('UN'),('Donor')
ON CONFLICT DO NOTHING;

INSERT INTO inso.partner_status (name) VALUES
('Registered'),('Unregistered')
ON CONFLICT DO NOTHING;

INSERT INTO inso.required_doc_type (code, description) VALUES
('ATTENDANCE','Signed attendance sheet'),
('SLIDES','Presentation slides'),
('MINUTES','Session minutes/notes')
ON CONFLICT DO NOTHING;
