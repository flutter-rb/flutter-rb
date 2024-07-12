# frozen_string_literal: true

require_relative './gradle'

module FlutterRb
  # Represents an Android project folder.
  class AndroidFolder
    # Initializes a new instance of AndroidFolder.
    #
    # @param path [String] The path to the Android project folder.
    def initialize(path)
      @path = path
      # Parse the Gradle build file and store the parsed data.
      @gradle = GradleParser.new(@path).parse
    end

    # Returns the path to the Android project folder.
    #
    # @return [String] The path to the Android project folder.
    attr_reader :path

    # Returns the parsed Gradle build file data.
    #
    # @return [GradleParser] The parsed Gradle build file data.
    attr_reader :gradle
  end
end
