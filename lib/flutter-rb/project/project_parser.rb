require_relative './project'
require_relative './specs/flutter/pubspec'
require_relative './specs/flutter/dev_dependency'
require_relative './specs/flutter/platform_plugin'
require_relative './specs/android/android_folder'
require_relative './specs/android/gradle'
require_relative './specs/ios/ios_folder'

require 'yaml'

module FlutterRb
  # Flutter plugin project parser
  class ProjectParser
    def initialize(path)
      @path = path
    end

    def project
      File.exist?("#{@path}/pubspec.yaml") ? parse_project(@path) : nil
    end

    private

    def parse_project(path)
      pubspec_path = "#{@path}/pubspec.yaml"
      android_path = "#{path}/android"
      ios_path = "#{path}/ios"
      Project.new(
        PubspecParser.new(YAML.load_file(pubspec_path)).parse,
        File.exist?(android_path) ? AndroidFolder.new(android_path) : nil,
        File.exist?(ios_path) ? IOSFolder.new(ios_path) : nil
      )
    end
  end
end
