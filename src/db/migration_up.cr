require "./migrations/**"

module BrokenCrystals
    Initial.new.up()
    Users.new.up()
end
