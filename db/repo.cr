require "pg"
require "crecto"
require "dotenv"

env = Dotenv.load ".env"

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::Postgres
    conf.uri = env["POSTGRES_URL"]
  end
end
