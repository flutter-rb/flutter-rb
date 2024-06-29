# frozen_string_literal: true

require 'dry/cli'
require 'rubygems'

module CLI
  # Module for all CLI commands.
  module Commands
    extend Dry::CLI::Registry

    # This class represents the inspect command for the CLI.
    # It inherits from Dry::CLI::Command and provides functionality to inspect Dart/Flutter projects.
    class Inspect < ::Dry::CLI::Command
      # Description of the command.
      # This will be displayed when the user runs `flutter-rb help inspect`.
      desc 'Inspects Dart/Flutter project'

      # Option for specifying the path to the Dart/Flutter project.
      # If not provided, the current working directory will be used.
      option :path,
             default: '',
             desc: 'Path to Dart/Flutter project. If empty, flutter-rb uses current path'

      # Option for specifying the report system format.
      # If not provided, no report will be generated.
      option :report,
             default: '',
             values: ['', 'checkstyle'],
             desc: "Report system format. If empty, flutter-rb won't generate report"

      # The main method of the command.
      # This method is called when the user runs `flutter-rb inspect`.
      #
      # Parameters:
      # - options: A hash containing the command-line options.
      #
      # Returns:
      #   nil: This method does not return any value. It only performs an action.
      def call(**options)
        # Create a new instance of FlutterRb::FlutterRb.
        flutter_rb = FlutterRb::FlutterRb.new

        # Fetch the path and report options from the command-line options.
        path = options.fetch(:path)
        report = options.fetch(:report)

        # Start the inspection process with the provided path and report option.
        flutter_rb.start(
          path.empty? ? ::Dir.pwd : path,
          report == options.fetch(:report)
        )
      end
    end

    # This class represents the version command for the CLI.
    # It inherits from Dry::CLI::Command and provides functionality to print the current version of flutter-rb.
    class Version < ::Dry::CLI::Command
      # Description of the command.
      # This will be displayed when the user runs `flutter-rb help version`.
      desc 'Prints using version of flutter-rb'

      # The main method of the command.
      # This method is called when the user runs `flutter-rb version`.
      #
      # Returns:
      #   nil: This method does not return any value. It only prints the version to the console.
      def call
        # Load the flutter-rb gemspec file to get the version.
        # The gemspec file contains metadata about the gem.
        spec = Gem::Specification.load('flutter_rb.gemspec')

        # Print the version to the console.
        puts spec.version
      end
    end

    class Author < ::Dry::CLI::Command
      desc 'Prints the author of flutter-rb'

      def call
        spec = Gem::Specification.load('flutter_rb.gemspec')

        puts "Authors: #{spec.authors.join(', ').strip}"
        puts "Email: #{spec.email}"
        puts "Homepage: #{spec.homepage}"
      end
    end

    register 'inspect', Inspect, aliases: ['i']
    register 'version', Version, aliases: ['v']
    register 'author', Author, aliases: ['a']
  end
end

# rubocop:disable Layout/LineLength
#
if ::ARGV.empty?
  puts '⚠️ WARNING ⚠️'.colorize(:yellow)
  puts '👉 You are using legacy CLI for flutter-rb. To migrate to new CLI, you need to read documentation by following link: https://github.com/flutter-rb/flutter-rb/'
  puts '👉 This message are showing only for versions that supports legacy CLI.'
  puts '👉 You will need to upgrade your build setup for new CLI because old version will be removed in future versions of flutter-rb.'
  puts '👉 If you have any questions, feel free to open an issue in our repository by following link: https://github.com/flutter-rb/flutter-rb/issues/new'
  puts "\n"

  flutter_rb = FlutterRb::FlutterRb.new

  flutter_rb.start(::Dir.pwd, true)
else
  ::Dry::CLI.new(::CLI::Commands).call
end

# rubocop:enable Layout/LineLength
