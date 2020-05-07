module BrokenCrystals
  class Comment
    def initialize(@id : String, @name : String, @comment : String)
    end

    def id
      @id
    end

    def name
      @name
    end

    def comment
      @comment
    end
  end
end
