require "../repositories/*"
require "../models/*"
require "kemal"
require "kemal-session"

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

    get "/logout" do |env|
      env.response.headers["Content-Type"] = "text/html"
      env.session.destroy
      "<h1>You have been logged out.</h1> <a href='/login'> Login</a>"
    end

    get "/me" do |env|
      env.response.headers["Content-Type"] = "text/plain"
      user = env.session.object("user").as(UserSession)
      "You are authenticated as #{user.username}"
    end

    post "/login" do |env|
      username = env.params.body["username"].as(String)
      password = env.params.body["password"].as(String)
      result = read_repo.select_where("username", username, ["id", "username", "email", "password"])

      user = nil
      pass = nil
      email = nil
      id = nil

      result.each do
        id = result.read(String)
        user = result.read(String)
        email = result.read(String)
        pass = result.read(String)
      end

      unless user && id && email && pass
        raise "Unathorized"
      end

      if pass != password
        raise "Invalid credentials"
      end

      user = UserSession.new(id, user, email)
      env.session.object("user", user)
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
