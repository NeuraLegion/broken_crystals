require "../repositories/*"
require "../models"

module BrokenCrystals
  module HomeController
    HOME_PREFIX = ""
    get "/" do |env|
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/main.ecr"
    end

    get "/vulns" do |env|
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/vulns.ecr"
    end
  end
end
