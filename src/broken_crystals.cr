# TODO: Write documentation for `BrokenCrystals`
require "./controllers/**"
require "./repositories/*"
require "./models/*"
require "../public/**"
require "kemal"
require "ecr"
require "json"

module BrokenCrystals
  VERSION = "0.1.0"

  include UserController

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

  get "/greeter" do |_|
  end

  post "/greeter" do |_|
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

  # <script>alert(1)</script>
  get "/xss_one" do |env|
    id = env.params.query["id"]? || "1"
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/reflected_xss.ecr"
  end

  # <sCrIpt>alert(1)</sCriPt>
  get "/xss_two" do |env|
    id = env.params.query["id"]? || "2"
    ["<script>", "</script>"].each { |var| id = id.gsub(var, "") }
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/reflected_xss.ecr"
  end

  # <scr<script>ipt>alert(1)</scr</script>ipt>
  get "/xss_three" do |env|
    id = env.params.query["id"]? || "3"
    [/<script>/i, /<\/script>/i].each { |r| id = id.gsub(r, "") }
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/reflected_xss.ecr"
  end

  # <a onmouseover="alert(1)"\>Click me!</a\>
  get "/xss_four" do |env|
    id = env.params.query["id"]? || "4"
    id = id.gsub(/script/i, "")
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/reflected_xss.ecr"
  end

  # <script>eval(String.fromCharCode(97, 108, 101, 114, 116, 40, 53, 41))</script>
  get "/xss_five" do |env|
    id = env.params.query["id"]? || "5"
    id = id.gsub(/alert/i, "")
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/reflected_xss.ecr"
  end

  # "%3Balert(6)%3B"
  get "/xss_six" do |env|
    id = <<-EOF
      <script>
        var id = "#{URI.decode(env.params.query["id"]? || "6")}";
      </script>
      EOF
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/reflected_xss.ecr"
  end

  get "/dom_xss" do |env|
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/dom_xss.ecr"
  end

  get "/dom_xss2" do |env|
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/dom_xss2.ecr"
  end

  # ../../../../../../../etc/passwd
  get "/lfi_one" do |env|
    image = env.params.query["image"]?
    image = "public/LFI/#{image}"
    send_file env, image
    env.response.headers["Content-Type"] = "text/html"
  end

  # ....//....//....//....//....//....//etc/passwd
  get "/lfi_two" do |env|
    image = env.params.query["image"]?
    image = "public/LFI/#{image}"
    image = image.gsub("../", "")
    send_file env, image
    env.response.headers["Content-Type"] = "text/html"
  end

  get "/pxss_one" do |env|
    read_repo = ReadRepository.new "comments"

    results = read_repo.select
    comments = Array(Comment).new
    results.each do
      results.read(String)

      comment = results.read(String)
      name = results.read(String)

      comments << Comment.new(name, comment)
    end

    env.response.headers["Content-Type"] = "text/html"
    render "src/views/pxss_one.ecr"
  end

  post "/pxss_one" do |env|
    comments = Array(Comment).new
    mutable_repo = MutableRepository.new "comments"

    name = env.params.body["name"].as(String)
    content = env.params.body["content"].as(String)

    env.response.headers["Content-Type"] = "text/html"
    if name && content
      mutable_repo.insert(["name", "content"], [name, content])
      env.redirect "/pxss_one"
    end

    render "src/views/error.ecr"
  end

  get "/csrf" do |env|
    env.response.headers["Content-Type"] = "text/html"
    render "src/views/csrf.ecr"
  end

  post "/csrf" do |env|
    env.response.headers["Content-Type"] = "text/html"
    env.response.headers["Access-Control-Allow-Origin"] = "*"
    # need to figure out usage for these
    # account = env.params.body["account"]
    amount = env.params.body["amount"].as(String)
    render "src/views/csrf_rss.ecr"
  end

  Kemal.run
end
