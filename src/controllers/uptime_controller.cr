require "../repositories/*"
require "kemal"

module BrokenCrystals
  module UptimeController
    UPTIME_PREFIX = "/vuln/uptime"

    get "#{UPTIME_PREFIX}/1" do |env|
      response = `#{env.params.query["command"]? || "uptime"}`
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/uptime.ecr"
    end

    # uptime%3B%20%2Fbin%2Fcat%20%2Fetc%2Fpasswd
    get "#{UPTIME_PREFIX}/2" do |env|
      command = env.params.query["command"]? || "uptime"
      unless command.includes?("uptime")
        command = "uptime"
      end

      response = `#{command}`
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/uptime.ecr"
    end

    # uptime%20%7C%20%2Fbin%2Fcat%20%2Fetc%2Fpasswd
    get "#{UPTIME_PREFIX}/3" do |env|
      command = env.params.query["command"]? || "uptime"

      [";", "&", "&&", "%3B%0A", "%26", "%26%26"].each { |var| command = command.gsub(var, "") }
      unless command.includes?("uptime")
        command = "uptime"
      end

      response = `#{command}`
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/uptime.ecr"
    end

    # uptime%20%7C%20%2Fb?n%2Fc?t%20%2Fetc%2Fpasswd
    get "#{UPTIME_PREFIX}/4" do |env|
      command = env.params.query["command"]? || "uptime"

      [";", "&", "&&", "%3B%0A", "%26", "%26%26"].each { |var| command = command.gsub(var, "") }
      ["/bin", "/sbin", "/lib", "/opt"].each { |var| command = command.gsub(var, "") }
      ["cat", "ping", "netstat", "ps", "whoami"].each { |var| command = command.gsub(var, "") }
      unless command.includes?("uptime")
        command = "uptime"
      end

      response = `#{command}`
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/uptime.ecr"
    end
  end
end
