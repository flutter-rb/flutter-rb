# frozen_string_literal: true

require 'dry/cli'

module CLI
  # Module for all CLI commands.
  module Commands
    extend Dry::CLI::Registry

    # Main entry point.
    class Inspect < ::Dry::CLI::Command
      option :path,
             default: '',
             desc: 'Path to Dart/Flutter project. If empty, flutter-rb uses current path'
      option :report,
             default: '',
             values: ['', 'checkstyle'],
             desc: "Report system format. If empty, flutter-rb won't generate report"

      def call(**options)
        flutter_rb = FlutterRb::FlutterRb.new

        path = options.fetch(:path)
        report = options.fetch(:report)

        flutter_rb.start(
          path.empty? ? ::Dir.pwd : path,
          report == options.fetch(:report)
        )
      end
    end

    register 'inspect', Inspect
  end
end

# rubocop:disable Layout/LineLength
#
if ::ARGV.empty?
  puts '⚠️ WARNING ⚠️'.colorize(:yellow)
  puts '👉 You are using legacy CLI for flutter-rb. Please, visit https://github.com/flutter-rb/flutter-rb for more information.'
  puts '👉 This message showing only for versions that allows news CLI interface.'
  puts '👉 You will need to upgrade your build setup for new CLI because this script will be removed in future versions of flutter-rb.'
  puts "\n"

  flutter_rb = FlutterRb::FlutterRb.new

  flutter_rb.start(::Dir.pwd, true)
else
  ::Dry::CLI.new(::CLI::Commands).call
end

# rubocop:enable Layout/LineLength
