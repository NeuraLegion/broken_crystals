require "pg"

abstract class Migration
    property query_runner

    def initialize 
        db = DB.open(url)
    end

    abstract def up()
    abstract def down()
end
