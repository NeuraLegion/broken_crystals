require "../repositories/*"
require "../models"
require "../../db/repo"

module BrokenCrystals
  module HomeController
    Query = Crecto::Repo::Query.new

    HOME_PREFIX = ""
    get "/" do |env|
      env.response.headers["Content-Type"] = "text/html"
      products = Repo.all(Models::Product, Query.preload([:photos, :category]))
      testimonials = Repo.all(Models::Testimonial)
      render "src/views/main.ecr"
    end

    post "/" do |env|
      env.response.headers["Content-Type"] = "text/html"

      name = env.params.body["name"].as(String)
      job_title = env.params.body["job-title"].as(String)
      testimonial = env.params.body["testimonial"].as(String)

      object = Models::Testimonial.new
      object.name = name
      object.title = job_title
      object.testimonial = testimonial
      Repo.insert(object)

      products = Repo.all(Models::Product, Query.preload([:photos, :category]))
      testimonials = Repo.all(Models::Testimonial)
      render "src/views/main.ecr"
    end

    get "/vulns" do |env|
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/vulns.ecr"
    end
  end
end
