require_relative './specs/flutter/pubspec'
require_relative './specs/flutter/dev_dependency'
require_relative './specs/flutter/platform_plugin'
require_relative './specs/android/android_folder'
require_relative './specs/android/gradle'
require_relative './specs/ios/ios_folder'

require 'yaml'

module FlutterRb
  # Project representation
  class Project
    def initialize(
      path,
      pubspec,
      android_folder,
      ios_folder
    )
      @path = path
      @pubspec = pubspec
      @android_folder = android_folder
      @ios_folder = ios_folder
    end

    attr_accessor :path, :pubspec, :android_folder, :ios_folder
  end

  # Flutter plugin project parser
  class ProjectParser
    def initialize(path)
      @path = path
    end

    def project
      File.exist?("#{@path}/pubspec.yaml") ? parse_project : nil
    end

    private

    def parse_project
      pubspec_path = "#{@path}/pubspec.yaml"
      android_path = "#{@path}/android"
      ios_path = "#{@path}/ios"
      pubspec = PubspecParser.new(pubspec_path, YAML.load_file(pubspec_path)).parse
      Project.new(
        @path,
        pubspec,
        File.exist?(android_path) ? AndroidFolder.new(android_path) : nil,
        File.exist?(ios_path) ? IOSFolder.new(ios_path, pubspec) : nil
      )
    end
  end
end
