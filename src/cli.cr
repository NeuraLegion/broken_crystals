require "clim"

class MyCli < Clim
  main do
    desc "Broken Crystals CLI"
    usage "bin/cli [options] [arguments] ..."
    version "Version 0.1.0"
    option "-c COMMAND", "--command=COMMAND", type: String, desc: "Executing commands. Avaiable are: 'run', 'ameba'."
    run do |opts, _|
      case opts.command
      when "run"
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
