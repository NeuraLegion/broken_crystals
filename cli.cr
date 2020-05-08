require "clim"

class MyCli < Clim
  main do
    desc "Broken crytal cli run tool."
    usage "hello [options] [arguments] ..."
    version "Version 0.1.0"
    option "-c COMMAND", "--command=COMMAND", type: String, desc: "Executing commands. Avaiable are: 'migration_run', 'migration_revert', 'app_run', 'ameba'."
    run do |opts, _|
      case opts.command
      when "migration_run"
        `env $(cat .env) crystal ./src/db/migration_up.cr`
        pp "migrated"
      when "migration_revert"
        `env $(cat .env) crystal ./src/db/migration_down.cr`
        pp "downgrated"
      when "app_run"
        pp "App starting. Visit http://0.0.0.0:3000 to access"
        `env $(cat .env) crystal ./src/broken_crystals.cr`
      when "ameba"
        pp "Running ameba..."
        Process.run("bin/ameba". ["except", "Metrics/CyclomaticComplexity", "--except", "Lint/UselessAssign"], output: STDOUT, error: STDOUT)
      else
        pp "No valid command supplied"
      end
    end
  end
end

MyCli.start(ARGV)
