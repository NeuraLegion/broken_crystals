require "../repositories/*"
require "kemal"

module BrokenCrystals
  module CsrfController
    CSRF_PREFIX = "/vuln/csrf"

    get "#{CSRF_PREFIX}" do |env|
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/csrf.ecr"
    end

    post "#{CSRF_PREFIX}" do |env|
      env.response.headers["Content-Type"] = "text/html"
      env.response.headers["Access-Control-Allow-Origin"] = "*"
      # TODO(dzeva.alibegovic@neuralegion.com, miki.halilcevic@gmail.com):
      # need to figure out usage for these
      # account = env.params.body["account"]
      amount = env.params.body["amount"].as(String)
      render "src/views/csrf_rss.ecr"
    end
  end
end
