# frozen_string_literal: true

require 'json'

module FlutterRb
  # Represents a Gradle project.
  class Gradle
    # Initializes a new Gradle instance.
    #
    # @param path [String] The path to the Gradle project.
    # @param version [String] The version of Gradle being used.
    def initialize(path, version)
      @path = path
      @version = version
    end

    # Returns the path to the Gradle project.
    #
    # @return [String] The path to the Gradle project.
    attr_reader :path

    # Returns the version of Gradle being used.
    #
    # @return [String] The version of Gradle being used.
    attr_reader :version
  end

  # This class is responsible for parsing Gradle project information.
  class GradleParser
    # Initializes a new GradleParser instance.
    #
    # @param path [String] The path to the Gradle project.
    def initialize(path)
      @path = path
    end

    # Parses the Gradle project information.
    #
    # Executes the 'prepareInfo' task in the Gradle project and reads the generated JSON file.
    # If the JSON file does not exist, it raises an error.
    #
    # @return [Gradle] An instance of Gradle with the parsed information.
    def parse
      `gradle -p #{@path} -q prepareInfo` # Execute the 'prepareInfo' task in the Gradle project
      info_file_path = "#{@path}/flutter_rb_gradle_plugin_output.json" # Path to the JSON file

      unless File.exist?(info_file_path) # Check if the JSON file exists
        raise "Could not find Gradle info file at #{info_file_path}" # Raise an error if the JSON file does not exist
      end

      info_file = File.read info_file_path # Read the JSON file
      info = JSON.parse info_file # Parse the JSON content

      Gradle.new(@path, info['version']) # Create a new Gradle instance with the parsed information
    end
  end
end
