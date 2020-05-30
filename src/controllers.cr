require "./controllers/*"

module BrokenCrystals
  module Controllers
    include HomeController

    include UserController

    include VulnController

    include XSSController

    include LFIController

    include UptimeController

    include CsrfController
  end
end
