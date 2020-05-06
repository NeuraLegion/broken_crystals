require "pg"

module BrokenCrystals
  class DBWrapper
    @query_runner : DB::Database

    def initialize
      @query_runner = DB.open(ENV["POSTGRES_URL"]? || "postgresql://postgres:password@localhost:5432/broken_crystal")
    end

    def exec(query : String)
      @query_runner.query(query)
    end

    def sanitize(values : Array)
      values.map { |v| v.is_a?(String) ? "'#{v}'" : v }
    end
  end
end
