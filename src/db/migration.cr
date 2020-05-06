require "pg"

module BrokenCrystals
  abstract class Migration
    @query_runner : DB::Database

    abstract def up
    abstract def down

    def initialize
      @query_runner = DB.open(ENV["POSTGRES_URL"])
    end
  end
end
