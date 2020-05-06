require "../migration"

module BrokenCrystals
    class Users < Migration
        def up()
            @query_runner.query %|CREATE TABLE IF NOT EXISTS "users" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "username" character varying NOT NULL, "email" character varying NOT NULL, "password" character varying NOT NULL, CONSTRAINT "UK_users_email" UNIQUE ("email"), CONSTRAINT "PK_users" PRIMARY KEY ("id"))|
        end

        def down()
            @query_runner.query %|DROP TABLE IF EXISTS "users"|
        end
    end
end