require "optparse"
# we have to require the environment....
ENV["RAILS_ROOT"] = File.expand_path("../dummy", __FILE__)
require File.expand_path("../../../spec/dummy/config/environment", __FILE__)
require "teabag"

module Teabag
  class Cli

    def initialize
      @options = {}
      opt_parser.parse!

      require "teabag/console"
      fail if Teabag::Console.new(ENV["suite"]).execute
    end

    def opt_parser
      options = @options
      OptionParser.new do |parser|
        parser.banner = "Usage: teabag [options] [filter]\n\n"

        parser.on("-O", "--options PATH", "Specify the path to a custom options file.") do |path|
          options[:custom_options_file] = path
        end

        parser.on("-s", "--suppress-logs", "Suppress logs coming from console.log.") do |path|
          options[:suppress_logs] = true
        end

        parser.on("--fail-fast", "Abort the run on first suite failure.") do |o|
          options[:fail_fast] = true
        end

        parser.separator("\n  **** Output ****\n\n")

        parser.on("-f", "--format FORMATTERS", "Specify formatters",
                  "  progress (default - dots)",
                  "  documentation (group and example names)",
                  "  custom formatter class name") do |o|
          options[:formatters] ||= []
          options[:formatters] << [o]
        end

        #parser.on("-c", "--[no-]color", "--[no-]colour", "Enable color in the output.") do |o|
        #  options[:color] = o
        #end

        parser.separator("\n  **** Utility ****\n\n")

        parser.on("-v", "--version", "Display the version.") do
          puts Teabag::VERSION
          exit
        end

        parser.on("-h", "--help", "You're looking at it.") do
          puts parser
          exit
        end
      end
    end

  end
end
