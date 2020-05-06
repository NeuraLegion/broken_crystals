require "../repositories/*"
require "kemal"

module BrokenCrystals
    module UserController
        PREFIX = "users"
        mutableRepo = MutableRepository.new "users"
        readRepo = ReadRepository.new "users"
        
        get "/register" do |env|
            env.response.headers["Content-Type"] = "text/html"
            render "src/views/users/register.ecr"
        end
        
        post "/register" do |env|
            username = env.params.body["username"].as(String)
            email = env.params.body["email"].as(String)
            password = env.params.body["password"].as(String)
            mutableRepo.insert(["username", "email", "password"], [username, email, password])
            env.response.headers["Content-Type"] = "text/html"
            render "src/views/users/login.ecr"
        end

        get "/login" do |env|
            env.response.headers["Content-Type"] = "text/html"
            render "src/views/users/login.ecr"
        end

        post "/login" do |env|
            username = env.params.body["username"].as(String)
            password = env.params.body["password"].as(String)
            result = readRepo.select_where("username", username)
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

    end
end