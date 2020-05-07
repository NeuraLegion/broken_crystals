module BrokenCrystals
  class Comment
    def initialize(@name : String, @comment : String)
    end

    def name
      @name
    end

    def comment
      @comment
    end
  end
end
