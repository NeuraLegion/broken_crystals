require "../migration"

module BrokenCrystals
  class Comments < Migration
    def up
      @query_runner.query %|CREATE TABLE IF NOT EXISTS "comments" 
        ("id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "content" character varying NOT NULL,
        "name" character varying NOT NULL,
        CONSTRAINT "PK_comments" PRIMARY KEY ("id")
        )|
    end

    def down
      @query_runner.query %|DROP TABLE IF EXISTS "comments"|
    end
  end
end
