module BrokenCrystals
  class ReadRepository
    @db : DBWrapper

    def initialize(@table : String)
      @db = DBWrapper.new
    end

    def select(columns : Array(String)? = nil)
      select_columns = columns && columns.size ? columns.join(", ") : "*"
      @db.exec("SELECT #{select_columns} FROM #{@table}")
    end


    def select_where(column : String, value : String | Int32, columns : Array(String)? = nil )
      value = value.is_a?(String) ? "'#{value}'" : value
      select_columns = columns && columns.size ? columns.join(", ") : "*"
      @db.exec("SELECT #{select_columns} FROM #{@table} WHERE #{column} = #{value}")
    end

    def select_where_in(column : String, value : Array(String) | Array(Int32), columns : Array(String)? = nil)
      value = value.map { |v| v.is_a?(String) ? "'#{v}'" : v }
      select_columns = columns && columns.size ? columns.join(", ") : "*"
      @db.exec("SELECT * FROM #{@table} WHERE #{column} IN #{value}")
    end

    def select_where_like(column : String, value : String, columns : Array(String)? = nil)
      value = value.is_a?(String) ? "'#{value}'" : value
      select_columns = columns && columns.size ? columns.join(", ") : "*"
      @db.exec("SELECT * FROM #{@table} WHERE #{column} ~ #{value}")
    end
  end
end
