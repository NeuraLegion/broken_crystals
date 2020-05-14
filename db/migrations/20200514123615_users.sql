-- +micrate Up
CREATE TABLE IF NOT EXISTS "users" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(), 
  "username" character varying NOT NULL, 
  "email" character varying NOT NULL, 
  "password" character varying NOT NULL, 
  CONSTRAINT "UK_users_email" UNIQUE ("email"), 
  CONSTRAINT "PK_users" PRIMARY KEY ("id")
);

-- +micrate Down
DROP TABLE IF EXISTS "users";
