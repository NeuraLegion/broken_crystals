-- +micrate Up
-- +micrate StatementBegin
DO $$
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'category') THEN
      CREATE TYPE "category" AS ENUM ('healing', 'jewellery', 'gemstones');
    END IF;
  END
$$;
-- +micrate StatementEnd
CREATE TABLE IF NOT EXISTS "products" (
  "id" SERIAL PRIMARY KEY,
  "name" character varying NOT NULL,
  "short_description" character varying NOT NULL,
  "description" character varying NOT NULL,
  "category" category NOT NULL
);

-- +micrate Down
DROP TABLE IF EXISTS "products";
DROP TYPE IF EXISTS "category";

