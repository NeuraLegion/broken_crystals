# TODO: Write documentation for `BrokenCrystals`
require "kemal"
require "ecr"

module BrokenCrystals
  VERSION = "0.1.0"

  get "/headers" do |env|
    headers = env.request.headers
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/headers.ecr"
  end

  get "/oops" do |env|
    env.response.headers["Content-Type"] = "text/html"
    raise "This is not ready it!"
    # When it will be ready remember to change the guest credentials from guest:guest
  end

  get "/" do |env|
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/main.ecr"
  end

  get "/uptime" do |env|
    response = `#{env.params.query["command"]? || "uptime"}`
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/uptime.ecr"
  end

  Kemal.run
end
