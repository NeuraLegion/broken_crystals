-- +micrate Up
CREATE TABLE IF NOT EXISTS "products" (
  "id" SERIAL PRIMARY KEY,
  "name" character varying NOT NULL,
  "short_description" character varying NOT NULL,
  "description" character varying NOT NULL,
  "category_id" int REFERENCES categories(id) ON DELETE CASCADE
);

-- +micrate Down
DROP TABLE IF EXISTS "products";

