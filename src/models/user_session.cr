require "json"
require "kemal"
require "kemal-session"

module BrokenCrystals
  class UserSession
    JSON.mapping({
      id:       String,
      username: String,
      email:    String,
    })
    include Kemal::Session::StorableObject

    def initialize(@id : String, @username : String, @email : String); end
  end
end
