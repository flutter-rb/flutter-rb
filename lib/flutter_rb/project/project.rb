# frozen_string_literal: true

require_relative './specs/flutter/pubspec'
require_relative './specs/flutter/dev_dependency'
require_relative './specs/flutter/platform_plugin'
require_relative './specs/android/android_folder'
require_relative './specs/android/gradle'
require_relative './specs/ios/ios_folder'

require 'yaml'

module FlutterRb
  # Represents a Flutter project.
  class Project
    # Initializes a new instance of Project.
    #
    # @param path [String] The path to the Flutter project.
    # @param pubspec [Pubspec] The parsed pubspec of the project.
    # @param android_folder [AndroidFolder, nil] The parsed Android folder of the project.
    # @param ios_folder [IOSFolder, nil] The parsed iOS folder of the project.
    def initialize(path, pubspec, android_folder, ios_folder)
      @path = path
      @pubspec = pubspec
      @android_folder = android_folder
      @ios_folder = ios_folder
    end

    # Accessor for the path of the project.
    #
    # @return [String] The path of the project.
    attr_accessor :path

    # Accessor for the pubspec of the project.
    #
    # @return [Pubspec] The pubspec of the project.
    attr_accessor :pubspec

    # Accessor for the Android folder of the project.
    #
    # @return [AndroidFolder] The Android folder of the project.
    attr_accessor :android_folder

    # Accessor for the iOS folder of the project.
    #
    # @return [IOSFolder] The iOS folder of the project.
    attr_accessor :ios_folder
  end

  # Class to parse and represent a Flutter project.
  class ProjectParser
    # Initializes a new instance of ProjectParser.
    #
    # @param path [String] The path to the Flutter project.
    def initialize(path)
      @path = path
    end

    # Parses the Flutter project at the given path and returns a Project object.
    #
    # @return [Project, nil] A Project object if the project exists and can be parsed, otherwise nil.
    def project
      File.exist?("#{@path}/pubspec.yaml") ? parse_project : nil
    end

    private

    # Parses the project at the given path and returns a Project object.
    #
    # @return [Project] A Project object representing the parsed project.
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
