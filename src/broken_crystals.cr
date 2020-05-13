# TODO: Write documentation for `BrokenCrystals`
require "./controllers/**"
require "./repositories/*"
require "./models/*"
require "./config"
require "kemal"
require "ecr"
require "log"

module BrokenCrystals
  VERSION = "0.1.0"
  CONFIG  = Config.new
  log_level = ::Log::Severity::Debug
  ::Log.builder.bind("*", log_level, ::Log::IOBackend.new)
  Log = ::Log.for("BrokenCrystals")

  include HomeController

  include UserController

  include VulnController

  include XSSController

  include LFIController

  include UptimeController

  include CsrfController

  Kemal::Session.config do |config|
    config.secret = CONFIG.session_secret
  end

  public_folder CONFIG.public_path

  Kemal.run
end
