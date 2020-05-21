-- +micrate Up
CREATE TABLE IF NOT EXISTS "categories" (
  "id" SERIAL PRIMARY KEY,
  "name" character varying NOT NULL UNIQUE
);

-- +micrate Down
DROP TABLE IF EXISTS "categories";
