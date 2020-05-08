# TODO: Write documentation for `BrokenCrystals`
require "./controllers/**"
require "./repositories/*"
require "./models/*"
require "../public/**"
require "kemal"
require "ecr"

module BrokenCrystals
  VERSION = "0.1.0"

  include HomeController

  include UserController

  include VulnController

  include XSSController

  include LFIController

  include UptimeController

  include CsrfController

  Kemal::Session.config do |config|
    config.secret = ENV["SESSION_SECRET"]
  end
  
  Kemal.run
end
