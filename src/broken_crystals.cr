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

  get "/greeter" do |env|
  end

  post "/greeter" do |env|
  end

  get "/uptime" do |env|
    response = `#{env.params.query["command"]? || "uptime"}`
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/uptime.ecr"
  end

  get "/picture" do |env|
    url = env.params.query["url"]?
    resp = HTTP::Client.get(url.to_s)
    env.response.headers["Content-Type"] = resp.content_type.to_s
    resp.body
  end

  get "/redirect" do |env|
    url = env.params.query["url"]?
    env.response.headers["Location"] = url.to_s
    env.response.status_code = 301
  end

  Kemal.run
end
