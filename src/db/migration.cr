require "pg"
require "../config"

module BrokenCrystals
  abstract class Migration
    @query_runner : DB::Database

    abstract def up
    abstract def down

    def initialize
      @query_runner = DB.open(CONFIG.postgres_url)
    end
  end
end
