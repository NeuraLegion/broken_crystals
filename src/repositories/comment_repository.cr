module BrokenCrystals
  class Comments
    @db : DBWrapper  = DBWrapper.new
    @table : String = "comments"
    @read_repo = ReadRepository.new "comments"

    def get_all()
      results = @read_repo.select(["id", "name", "content"])

      comments = Array(Comment).new
      results.each do
        comments << Comment.new(
          results.read(String),
          results.read(String),
          results.read(String)
        )
      end    

      comments
    end
  end
end
