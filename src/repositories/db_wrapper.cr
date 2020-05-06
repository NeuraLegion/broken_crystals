module BrokenCrystal
  class DBWrapper
    @queryRunner : DB::Database

    def initialize
      @query_runner = DB.open(ENV["POSTGRES_URL"])
    end
  end
end
