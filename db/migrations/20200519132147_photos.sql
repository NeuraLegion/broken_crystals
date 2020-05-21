-- +micrate Up
CREATE TABLE IF NOT EXISTS "photos" (
  "id" SERIAL PRIMARY KEY,
  "url" character varying NOT NULL,
  "product_id" int REFERENCES products(id) ON DELETE CASCADE
);

-- +micrate Down
DROP TABLE IF EXISTS "photos";

