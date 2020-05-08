require "../repositories/*"

module BrokenCrystals
  module LFIController
    LFI_PREFIX = "/vuln/lfi"

    # ../../../../../../../etc/passwd
    get "#{LFI_PREFIX}/1" do |env|
      image = env.params.query["image"]?
      image = "public/LFI/#{image}"
      env.response.headers["Content-Type"] = (MIME.from_extension?(Path.new(image).extension.to_s) || "text/html")
      send_file env, image
    end

    # a....//....//....//....//....//....//etc/passwd
    get "#{LFI_PREFIX}/2" do |env|
      image = env.params.query["image"]?
      image = "public/LFI/#{image}"
      image = image.gsub("../", "")
      env.response.headers["Content-Type"] = (MIME.from_extension?(Path.new(image).extension.to_s) || "text/html")
      send_file env, image
    end
  end
end
