require "../repositories/*"

module BrokenCrystals
  module XSSController
    XSS_PREFIX     = "/vuln/xss"
    PXSS_PREFIX    = "/vuln/pxss"
    DOM_XSS_PREFIX = "/vuln/dom_xss"
    comments_repo = Comments.new
    comment_mutable_repo = MutableRepository.new "comments"

    # <script>alert(1)</script>
    get "/#{XSS_PREFIX}/1" do |env|
      id = env.params.query["id"]? || "1"
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/reflected_xss.ecr"
    end

    # <sCrIpt>alert(1)</sCriPt>
    get "#{XSS_PREFIX}/2" do |env|
      id = env.params.query["id"]? || "2"
      ["<script>", "</script>"].each { |var| id = id.gsub(var, "") }
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/reflected_xss.ecr"
    end

    # <scr<script>ipt>alert(1)</scr</script>ipt>
    get "#{XSS_PREFIX}/3" do |env|
      id = env.params.query["id"]? || "3"
      [/<script>/i, /<\/script>/i].each { |r| id = id.gsub(r, "") }
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/reflected_xss.ecr"
    end

    # <a onmouseover="alert(1)"\>Click me!</a\>
    get "#{XSS_PREFIX}/4" do |env|
      id = env.params.query["id"]? || "4"
      id = id.gsub(/script/i, "")
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/reflected_xss.ecr"
    end

    # <script>eval(String.fromCharCode(97, 108, 101, 114, 116, 40, 53, 41))</script>
    get "#{XSS_PREFIX}/5" do |env|
      id = env.params.query["id"]? || "5"
      id = id.gsub(/alert/i, "")
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/reflected_xss.ecr"
    end

    # "%3Balert(6)%3B"
    get "#{XSS_PREFIX}/6" do |env|
      id = <<-EOF
      <script>
      var id = "#{URI.decode(env.params.query["id"]? || "6")}";
      </script>
      EOF
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/reflected_xss.ecr"
    end

    get "#{PXSS_PREFIX}" do |env|
      comments = comments_repo.get_all
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/pxss_one.ecr"
    end

    post "#{PXSS_PREFIX}" do |env|
      comments = comments_repo.get_all

      name = env.params.body["name"].as(String)
      content = env.params.body["content"].as(String)

      if !name || !content
        render "src/views/error.ecr"
      end

      comment_mutable_repo.insert(["name", "content"], [name, content])
      env.response.headers["Content-Type"] = "text/html"
      comments = comments_repo.get_all
      render "src/views/pxss_one.ecr"
    end

    get "#{DOM_XSS_PREFIX}/1" do |env|
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/dom_xss.ecr"
    end

    get "#{DOM_XSS_PREFIX}/2" do |env|
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/dom_xss2.ecr"
    end
  end
end
