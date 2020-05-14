-- +micrate Up
CREATE TABLE IF NOT EXISTS "comments" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "content" character varying NOT NULL,
        "name" character varying NOT NULL,
        CONSTRAINT "PK_comments" PRIMARY KEY ("id")
      );

-- +micrate Down
DROP TABLE IF EXISTS "comments";
