# TODO: Write documentation for `BrokenCrystals`
require "../public/**"
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

  Kemal.run
end
