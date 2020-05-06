module BrokenCrystals
    class ReadRepository
        @db: DBWrapper

        def initialize(@table : String)
            @db = DBWrapper.new
        end

        def select()
            @db.exec("SELECT * FROM #{@table}")
        end

        def select_where(column : String, value : String | Int32)
            value = value.is_a?(String) ? "'#{value}'" : value
            @db.exec("SELECT * FROM #{@table} WHERE #{column} = #{value}")
        end

        def select_where_in(column : String, value : Array(String | Int32))
            value = value.map{ |v| v.is_a?(String) ? "'#{v}'" : v }
            @db.exec("SELECT * FROM #{@table} WHERE #{column} IN #{value}")
        end

        def select_where_like(column : String, value : String)
            value = value.is_a?(String) ? "'#{value}'" : value
            @db.exec("SELECT * FROM #{@table} WHERE #{column} ~ #{value}")
        end
    end
  end
end
