# TODO: Write documentation for `BrokenCrystals`
require "./controllers"
require "./config"
require "kemal"
require "kemal-session"
require "ecr"
require "log"

module BrokenCrystals
  VERSION = "0.1.0"

  CONFIG = Config.new

  log_level = ::Log::Severity::Debug
  ::Log.builder.bind("*", log_level, ::Log::IOBackend.new)
  Log = ::Log.for("BrokenCrystals")

  include Controllers

  Kemal::Session.config do |config|
    config.secret = CONFIG.session_secret
  end

  public_folder CONFIG.public_path

  Kemal.run
end
