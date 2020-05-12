require "pg"

module BrokenCrystals
  class DBWrapper
    @query_runner : DB::Database

    def initialize
      @query_runner = DB.open(CONFIG.postgres_url)
    end

    def exec(query : String)
      @query_runner.query(query)
    end

    def sanitize(values : Array)
      values.map { |v| v.is_a?(String) ? "'#{v}'" : v }
    end
  end
end
