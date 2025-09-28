# MSBA_Principles_of_BA_project

Relational data solution for **INSO** quarterly activity tracking and donor reporting in Somalia.
The project replaces scattered spreadsheets with a small PostgreSQL database that stores events,
attendance, submissions, and uploaded evidence (attendance sheet, slides, minutes).

## What’s here
- `sql/01_schema.sql` — creates the `inso` schema and all tables (masters, events, attendance, submissions, uploads).
- `sql/02_sample_data.sql` — Somalia-tailored seed data (cities, orgs, participants, 5 sample events, submissions, uploads).
- `sql/04_template_solutions.sql` — template-style queries used in the assignment.
- `docs/INSO_Assignment_Report.pdf`  — 4–6 page write-up.
- `docs/ERD.png` — ER diagram of the `inso` schema .

## Quick start (PostgreSQL)
```bash
# 1) Create schema & tables
psql -d <your_db> -f sql/01_schema.sql

# 2) Load sample data
psql -d <your_db> -f sql/02_sample_data.sql

# 3) Run the assignment queries
psql -d <your_db> -f sql/04_template_solutions.sql
