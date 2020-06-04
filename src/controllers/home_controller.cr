require "../../db/repo"
require "../models"
require "kemal"

module BrokenCrystals
  module HomeController
    Query = Crecto::Repo::Query.new

    HOME_PREFIX = ""

    get "/" do |env|
      env.response.headers["Content-Type"] = "text/html"
      search = env.params.query["search"]?
      products = Repo.all(Models::Product, Query.preload([:photos, :category]))
      testimonials = Repo.all(Models::Testimonial)
      user = env.session.object?("user")
      render "src/views/main.ecr"
    end

    post "/" do |env|
      env.response.headers["Content-Type"] = "text/html"
      env.redirect "/"
    end

    get "/vulns" do |env|
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/vulns.ecr"
    end

    get "/photo" do |env|
      image = env.params.query["image"]?
      image = "public/img/#{image}"
      env.response.headers["Content-Type"] = (MIME.from_extension?(Path.new(image).extension.to_s) || "text/html")
      send_file env, image
    end
  end
end
