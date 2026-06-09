
-- v10 Core Find / Share schema
BEGIN;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE SCHEMA IF NOT EXISTS ref;
CREATE SCHEMA IF NOT EXISTS core;

-- Reference data tables
CREATE TABLE IF NOT EXISTS ref.establishment_family (
  establishment_family_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS ref.establishment_type (
  establishment_type_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  establishment_family_id UUID NOT NULL REFERENCES ref.establishment_family(establishment_family_id),
  source_family_id INTEGER,
  source_family_label TEXT,
  school_rollup BOOLEAN NOT NULL DEFAULT FALSE,
  college_rollup BOOLEAN NOT NULL DEFAULT FALSE,
  academy_rollup BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS ref.establishment_status (
  establishment_status_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS ref.education_phase_group (
  education_phase_group_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS ref.education_phase (
  education_phase_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  education_phase_group_id UUID NOT NULL REFERENCES ref.education_phase_group(education_phase_group_id),
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS ref.group_type (
  group_type_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS ref.role_type (
  role_type_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS ref.religious_character (
  religious_character_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- Core entity tables
CREATE TABLE IF NOT EXISTS core.person (
  person_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  display_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS core.role (
  role_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  person_id UUID NOT NULL REFERENCES core.person(person_id),
  role_type_id UUID NOT NULL REFERENCES ref.role_type(role_type_id)
);

CREATE TABLE IF NOT EXISTS core.establishment (
  establishment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  urn TEXT UNIQUE,
  uid TEXT UNIQUE,
  name TEXT NOT NULL,
  establishment_type_id UUID NOT NULL REFERENCES ref.establishment_type(establishment_type_id),
  establishment_status_id UUID NOT NULL REFERENCES ref.establishment_status(establishment_status_id),
  education_phase_id UUID NOT NULL REFERENCES ref.education_phase(education_phase_id),
  religious_character_id UUID REFERENCES ref.religious_character(religious_character_id),
  headteacher_role_assignment_id UUID
);

CREATE TABLE IF NOT EXISTS core.group_record (
  group_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  group_type_id UUID NOT NULL REFERENCES ref.group_type(group_type_id),
  headteacher_role_assignment_id UUID
);

-- Relationship tables
CREATE TABLE IF NOT EXISTS core.role_assignment (
  role_assignment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  role_id UUID NOT NULL REFERENCES core.role(role_id),
  establishment_id UUID REFERENCES core.establishment(establishment_id),
  group_id UUID REFERENCES core.group_record(group_id),
  CHECK (establishment_id IS NOT NULL OR group_id IS NOT NULL)
);

ALTER TABLE core.establishment
  ADD CONSTRAINT fk_establishment_headteacher_role_assignment
  FOREIGN KEY (headteacher_role_assignment_id) REFERENCES core.role_assignment(role_assignment_id);

ALTER TABLE core.group_record
  ADD CONSTRAINT fk_group_headteacher_role_assignment
  FOREIGN KEY (headteacher_role_assignment_id) REFERENCES core.role_assignment(role_assignment_id);

CREATE TABLE IF NOT EXISTS core.establishment_group_membership (
  establishment_group_membership_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  establishment_id UUID NOT NULL REFERENCES core.establishment(establishment_id),
  group_id UUID NOT NULL REFERENCES core.group_record(group_id),
  membership_category TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS core.group_group_membership (
  group_group_membership_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_group_id UUID NOT NULL REFERENCES core.group_record(group_id),
  child_group_id UUID NOT NULL REFERENCES core.group_record(group_id),
  CHECK (parent_group_id <> child_group_id)
);

-- History / event table
CREATE TABLE IF NOT EXISTS core.establishment_status_history (
  establishment_status_history_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  establishment_id UUID NOT NULL REFERENCES core.establishment(establishment_id) ON DELETE CASCADE,
  old_establishment_status_id UUID REFERENCES ref.establishment_status(establishment_status_id),
  new_establishment_status_id UUID NOT NULL REFERENCES ref.establishment_status(establishment_status_id),
  changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMIT;
