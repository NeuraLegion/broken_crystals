require "../repositories/*"

module BrokenCrystals
  module VulnController
    VULN_PREFIX = "/vuln"
      get "#{VULN_PREFIX}/headers" do |env|
        headers = env.request.headers
        env.response.headers["Content-Type"] = "text/html"
        render "src/views/headers.ecr"
      end

      get "#{VULN_PREFIX}/oops" do |env|
        env.response.headers["Content-Type"] = "text/html"
        raise "This is not ready it!"
        # When it will be ready remember to change the guest credentials from guest:guest
      end

      get "#{VULN_PREFIX}/picture" do |env|
        url = env.params.query["url"]?
        resp = HTTP::Client.get(url.to_s)
        env.response.headers["Content-Type"] = resp.content_type.to_s
        resp.body
      end

      get "#{VULN_PREFIX}/redirect" do |env|
        url = env.params.query["url"]?
        env.response.headers["Location"] = url.to_s
        env.response.status_code = 301
      end
  end
end
