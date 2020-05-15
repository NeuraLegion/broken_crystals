require "../repositories/*"
require "../models/*"
require "kemal"
require "kemal-session"

module BrokenCrystals
  module UserController
    SHOP_PREFIX = "shop"
    mutable_repo = MutableRepository.new "products"
    read_repo = ReadRepository.new "products"

    get "/marketplace" do |env|
      title = "Marketplace"
      env.response.headers["Content-Type"] = "text/html"
      products = read_repo.select
      render "src/views/shop/listing.ecr", "src/views/shop/layout.ecr"
    end

    get "/item" do |env|
      title = "Item"
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/shop/detail.ecr", "src/views/shop/layout.ecr"
    end
  end
end
