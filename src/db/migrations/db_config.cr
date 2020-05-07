require "../migration"

module BrokenCrystals
  class Initial < Migration
    def up
      @query_runner.query(%|CREATE EXTENSION IF NOT EXISTS "uuid-ossp";|)
      @query_runner.query(%|CREATE EXTENSION IF NOT EXISTS "btree_gist";|)
    end

    def down
      @query_runner.query(%|DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;|)
      @query_runner.query(%|DROP EXTENSION IF EXISTS "btree_gist" CASCADE;|)
    end
  end
end
