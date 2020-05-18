-- +micrate Up
CREATE TABLE IF NOT EXISTS "photos" (
  "id" SERIAL PRIMARY KEY,
  "url" character varying NOT NULL,
  "product" int REFERENCES products(id)
);

-- +micrate Down
DROP TABLE IF EXISTS "photos";
