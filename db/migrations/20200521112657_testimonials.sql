-- +micrate Up
CREATE TABLE IF NOT EXISTS "testimonials" (
        "id" SERIAL PRIMARY KEY,
        "name" character varying NOT NULL,
        "title" character varying NOT NULL,
        "testimonial" character varying NOT NULL
      );

-- +micrate Down
DROP TABLE IF EXISTS "testimonials";
