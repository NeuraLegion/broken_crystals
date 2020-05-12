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
        pp "RUNNING MIGRATIONS"
        Process.run("crystal", ["./src/db/migration_up.cr"], output: STDOUT, error: STDOUT)
        pp "MIGRATIED"
      when "migration_revert"
        pp "REVERTING ALL MIGRATIONS"
        Process.run("crystal", ["./src/db/migration_down.cr"], output: STDOUT, error: STDOUT)
        pp "DATABASE REVERTED"
      when "app_run"
        Process.run("crystal", ["./src/broken_crystals.cr"], output: STDOUT, error: STDOUT)
      when "ameba"
        pp "Running ameba..."
        Process.run("bin/ameba", ["except", "Metrics/CyclomaticComplexity", "--except", "Lint/UselessAssign"], output: STDOUT, error: STDOUT)
      else
        pp "No valid command supplied"
      end
    end
  end
end

MyCli.start(ARGV)
