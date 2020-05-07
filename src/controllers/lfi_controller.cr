require "../repositories/*"

module BrokenCrystals
  module LFIController
    LFI_PREFIX = "/vuln/lfi"

    # ../../../../../../../etc/passwd
    get "#{LFI_PREFIX}/1" do |env|
      image = env.params.query["image"]?
      image = "public/LFI/#{image}"
      send_file env, image
      env.response.headers["Content-Type"] = "text/html"
    end

    # ....//....//....//....//....//....//etc/passwd
    get "#{LFI_PREFIX}/2" do |env|
      image = env.params.query["image"]?
      image = "public/LFI/#{image}"
      image = image.gsub("../", "")
      send_file env, image
      env.response.headers["Content-Type"] = "text/html"
    end
  end
end
