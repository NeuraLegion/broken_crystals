module BrokenCrystal
  class MutableRepository
    @db : DBWrapper

    def initialize(@table : String)
    end

    def insert(insert_columns : Array(String), values : Array)
      @db.query_runner.query("INSERT INTO #{@table}(#{insert_columns.join(", ")}) VALUES(#{values.join(", ")})")
    end

    def update_all(update_columns : Array(String), values : String)
      update_statements = Array(String).new
      update_columns.each_index { |index| update_statements << "#{columns[index]} = #{values[index]}" }

      @db.query_runner.query("UPDATE #{@table} SET #{update_statements.join(", ")}")
    end

    def update_by_id(update_columns : Array(String), values : String, id : String)
      update_statements = Array(String).new
      update_columns.each_index { |index| update_statements << "#{columns[index]} = #{values[index]}" }

      @db.query_runner.query("UPDATE #{@table} SET #{update_statements.join(", ")} WHERE id = #{id}")
    end

    def delete_where(condition : String)
      @db.query_runner.query("DELETE FROM #{@table} WHERE #{condition}") # bad sql baaaad
    end

    def delete_by_id(id : String)
      @db.query_runner.query("DELETE FROM #{@table} WHERE id = #{id}")
    end
  end
end
