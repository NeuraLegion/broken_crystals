require "micrate"
require "pg"
require "dotenv"

env = Dotenv.load ".env"

Micrate::DB.connection_url = env["POSTGRES_URL"]
Micrate::Cli.run
