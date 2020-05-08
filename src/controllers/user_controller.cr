require "../repositories/*"
require "kemal"

module BrokenCrystals
  module UserController
    PREFIX = "users"
    mutable_repo = MutableRepository.new "users"
    read_repo = ReadRepository.new "users"

    get "/register" do |env|
      title = "Registration"
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/users/register.ecr", "src/views/users/auth_base.ecr"
    end

    post "/register" do |env|
      username = env.params.body["username"].as(String)
      email = env.params.body["email"].as(String)
      password = env.params.body["password"].as(String)
      mutable_repo.insert(["username", "email", "password"], [username, email, password])
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/users/login.ecr"
    end

    get "/login" do |env|
      title = "Login"
      env.response.headers["content-type"] = "text/html"
      render "src/views/users/login.ecr", "src/views/users/auth_base.ecr"
    end

    post "/login" do |env|
      username = env.params.body["username"].as(String)
      password = env.params.body["password"].as(String)
      result = read_repo.select_where("username", username)
      user = nil
      pass = nil
      result.each do
        result.read(String)
        user = result.read(String)
        result.read(String)
        pass = result.read(String)
      end

      if !user || pass != password
        raise "Unathorized"
      end

      # env.session.string("username", user) kemaaaaaal
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/users/dashboard.ecr"
    end

    get "/forgotten" do |env|
      title = "Forgotten password"
      env.response.headers["content-type"] = "text/html"
      render "src/views/users/forgotten.ecr", "src/views/users/auth_base.ecr"
    end
  end
end
