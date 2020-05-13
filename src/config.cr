require "dotenv"

module BrokenCrystals
  class Config
    @postgres_url : String
    @session_secret : String
    @public_path : String

    def initialize
      env = Dotenv.load ".env"
      @postgres_url = ENV["POSTGRES_URL"]? || env["POSTGRES_URL"]
      @session_secret = ENV["SESSION_SECRET"]? || env["SESSION_SECRET"]
      @public_path = ENV["PUBLIC_PATH"]? || env["PUBLIC_PATH"]
    end

    def postgres_url
      @postgres_url
    end

    def session_secret
      @session_secret
    end

    def public_path
      @public_path
    end
  end

  CONFIG = Config.new
end
