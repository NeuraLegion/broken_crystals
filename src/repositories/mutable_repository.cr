module BrokenCrystals
    class MutableRepository
        @db: DBWrapper

        def initialize(@table : String)
            @db = DBWrapper.new
        end

        def insert(insert_columns : Array(String), values : Array)
            @db.exec("INSERT INTO #{@table}(#{insert_columns.join(", ")}) VALUES(#{@db.sanitize(values).join(", ")})")
        end

    def update_all(update_columns : Array(String), values : String)
      update_statements = Array(String).new
      update_columns.each_index { |index| update_statements << "#{columns[index]} = #{values[index]}" }

            @db.exec("UPDATE #{@table} SET #{update_statements.join(", ")}")
        end

        def updateById(update_columns : Array(String), values : String, id : String)
            update_statements = Array(String).new
            values = @db.sanitize(values).join(", ")
            update_columns.each_index { |index| update_statements << "#{columns[index]} = #{values[index]}" }

            @db.exec("UPDATE #{@table} SET #{update_statements.join(", ")} WHERE id = #{id}")
        end

        def deleteWhere(condition : String)
            @db.exec("DELETE FROM #{@table} WHERE #{condition}") # bad sql baaaad
        end

        def deleteById(id : String)
            @db.exec("DELETE FROM #{@table} WHERE id = #{id}")
        end
    end
  end
end
