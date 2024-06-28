# frozen_string_literal: true

module FlutterRb
  # Represents the information contained in a Flutter project's pubspec.yaml file.
  class PubspecInfo
    # Initializes a new instance of PubspecInfo.
    #
    # @param name [String] The name of the Flutter project.
    # @param description [String] A brief description of the Flutter project.
    # @param version [String] The version number of the Flutter project.
    # @param author [String] The author of the Flutter project.
    # @param homepage [String] The homepage URL of the Flutter project.
    def initialize(name, description, version, author, homepage)
      @name = name
      @description = description
      @version = version
      @author = author
      @homepage = homepage
    end

    # Returns the name of the Flutter project.
    # @return [String] The name of the Flutter project.
    attr_reader :name

    # Returns the brief description of the Flutter project.
    # @return [String] The brief description of the Flutter project.
    attr_reader :description

    # Returns the version number of the Flutter project.
    # @return [String] The version number of the Flutter project.
    attr_reader :version

    # Returns the author of the Flutter project.
    # @return [String] The author of the Flutter project.
    attr_reader :author

    # Returns the homepage URL of the Flutter project.
    # @return [String] The homepage URL of the Flutter project.
    attr_reader :homepage
  end
end
