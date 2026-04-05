CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "password_hash" varchar,
  "system_id" integer,
  "created_at" timestamp
);

CREATE TABLE "systems" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "description" text,
  "created_at" timestamp
);

CREATE TABLE "system_relationships" (
  "id" integer PRIMARY KEY,
  "system_a_id" integer,
  "system_b_id" integer,
  "status" varchar,
  "created_at" timestamp
);

CREATE TABLE "members" (
  "id" integer PRIMARY KEY,
  "system_id" integer,
  "name" varchar,
  "pronouns" varchar,
  "description" text,
  "colour" varchar,
  "profile_picture_url" varchar,
  "is_custom_front" bool,
  "is_archived" bool,
  "folder_id" integer,
  "created_at" timestamp
);

CREATE TABLE "custom_fields" (
  "id" integer PRIMARY KEY,
  "member_id" integer,
  "definition_id" integer,
  "value" text,
  "created_at" timestamp
);

CREATE TABLE "custom_field_definitions" (
  "id" integer PRIMARY KEY,
  "system_id" integer,
  "field_name" varchar,
  "field_order" varchar,
  "created_at" timestamp
);

CREATE TABLE "member_privacy_settings" (
  "id" integer PRIMARY KEY,
  "member_id" integer,
  "is_private" bool,
  "suppress_notifications" bool
);

CREATE TABLE "member_hidden_fields" (
  "member_id" integer,
  "definition_id" integer,
  PRIMARY KEY ("member_id", "definition_id")
);

CREATE TABLE "folders" (
  "id" integer PRIMARY KEY,
  "system_id" integer,
  "parent_id" integer,
  "name" varchar,
  "colour" varchar
);

CREATE TABLE "front_entries" (
  "id" integer PRIMARY KEY,
  "system_id" integer,
  "member_id" integer,
  "started_at" timestamp,
  "ended_at" timestamp,
  "front_note" text,
  "front_status" varchar,
  "created_by_user_id" integer
);

CREATE TABLE "front_entry_comments" (
  "id" integer PRIMARY KEY,
  "front_entry_id" integer,
  "user_id" integer,
  "body" text,
  "created_at" timestamp
);

CREATE TABLE "journal_entries" (
  "id" integer PRIMARY KEY,
  "system_id" integer,
  "member_id" integer,
  "body" text,
  "created_at" timestamp
);

CREATE TABLE "push_subscriptions" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "subscription_json" text,
  "created_at" timestamp
);

COMMENT ON COLUMN "system_relationships"."status" IS 'pending, rejected, accepted';

ALTER TABLE "users" ADD FOREIGN KEY ("system_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "system_relationships" ADD FOREIGN KEY ("system_a_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "system_relationships" ADD FOREIGN KEY ("system_b_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "members" ADD FOREIGN KEY ("system_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "members" ADD FOREIGN KEY ("folder_id") REFERENCES "folders" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "custom_fields" ADD FOREIGN KEY ("member_id") REFERENCES "members" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "custom_fields" ADD FOREIGN KEY ("definition_id") REFERENCES "custom_field_definitions" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "custom_field_definitions" ADD FOREIGN KEY ("system_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "member_privacy_settings" ADD FOREIGN KEY ("member_id") REFERENCES "members" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "member_hidden_fields" ADD FOREIGN KEY ("member_id") REFERENCES "members" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "member_hidden_fields" ADD FOREIGN KEY ("definition_id") REFERENCES "custom_field_definitions" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "folders" ADD FOREIGN KEY ("system_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "folders" ADD FOREIGN KEY ("parent_id") REFERENCES "folders" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "front_entries" ADD FOREIGN KEY ("system_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "front_entries" ADD FOREIGN KEY ("member_id") REFERENCES "members" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "front_entries" ADD FOREIGN KEY ("created_by_user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "front_entry_comments" ADD FOREIGN KEY ("front_entry_id") REFERENCES "front_entries" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "front_entry_comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "journal_entries" ADD FOREIGN KEY ("system_id") REFERENCES "systems" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "journal_entries" ADD FOREIGN KEY ("member_id") REFERENCES "members" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "push_subscriptions" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;
