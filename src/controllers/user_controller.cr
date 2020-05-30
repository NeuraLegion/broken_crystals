require "../../db/repo"
require "../models"
require "../sessions"
require "kemal"
require "kemal-session"

module BrokenCrystals
  module UserController
    PREFIX = "users"

    get "/register" do |env|
      title = "Registration"
      env.response.headers["Content-Type"] = "text/html"
      render "src/views/users/register.ecr", "src/views/users/layout.ecr"
    end

    post "/register" do |env|
      username = env.params.body["username"].as(String)
      email = env.params.body["email"].as(String)
      password = env.params.body["password"].as(String)

      user = Models::User.new
      user.username = username
      user.email = email
      user.password = password
      Repo.insert(user)

      env.response.headers["Content-Type"] = "text/html"
      env.redirect "/login"
    end

    get "/login" do |env|
      title = "Login"
      env.response.headers["content-type"] = "text/html"
      render "src/views/users/login.ecr", "src/views/users/layout.ecr"
    end

    get "/logout" do |env|
      env.response.headers["Content-Type"] = "text/html"
      env.session.destroy
      env.redirect "/"
    end

    post "/login" do |env|
      username = env.params.body["username"].as(String)
      password = env.params.body["password"].as(String)

      user = Repo.get_by!(Models::User, username: username, password: password)

      unless user
        raise "Unathorized"
      end

      id = user.id.to_s
      username = user.username
      email = user.email

      user_session = UserSession.new(id, username, email) if id && username && email

      env.session.object("user", user_session) if user_session
      env.response.headers["Content-Type"] = "text/html"
      env.redirect "/"
    end

    get "/forgotten" do |env|
      title = "Forgotten password"
      env.response.headers["content-type"] = "text/html"
      render "src/views/users/forgotten.ecr", "src/views/users/layout.ecr"
    end
  end
end
