module BrokenCrystal
  class DBWrapper
    @query_runner : DB::Database

    def initialize
      @query_runner = DB.open(ENV["POSTGRES_URL"])
    end
  end
end
