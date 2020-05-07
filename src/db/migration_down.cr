require "./migrations/**"

module BrokenCrystals
  Initial.new.down
  Users.new.down
  Comments.new.down
end
