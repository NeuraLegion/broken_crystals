require "dotenv"

module BrokenCrystals
  class Config
    Log = BrokenCrystals::Log.for("Config")
    getter postgres_url : String
    getter session_secret : String
    getter public_path : String

    def initialize
      env = Dotenv.load ".env"
      @postgres_url = ENV["POSTGRES_URL"]? || env["POSTGRES_URL"]
      @session_secret = ENV["SESSION_SECRET"]? || env["SESSION_SECRET"]
      @public_path = ENV["PUBLIC_PATH"]? || env["PUBLIC_PATH"]
      data = <<-EOF
        postgres_url: #{@postgres_url}
        session_secret: #{@session_secret}
        public_path: #{@public_path}
        EOF

      Log.debug { data }
    end
  end
end
