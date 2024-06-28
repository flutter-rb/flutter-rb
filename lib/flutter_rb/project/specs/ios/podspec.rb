# frozen_string_literal: true

require 'cocoapods'

module FlutterRb
  # Represents a parsed Podspec file.
  class Podspec
    # Initializes a new instance of Podspec.
    #
    # @param path [String] The path to the Podspec file.
    # @param name [String] The name of the Podspec.
    # @param version [String] The version of the Podspec.
    # @param authors [Array<String>] The authors of the Podspec.
    # @param source [String] The source of the Podspec.
    def initialize(path, name, version, authors, source)
      @path = path
      @name = name
      @version = version
      @authors = authors
      @source = source
    end

    # Returns the path to the Podspec file.
    #
    # @return [String] The path to the Podspec file.
    attr_reader :path

    # Returns the name of the Podspec.
    #
    # @return [String] The name of the Podspec.
    attr_reader :name

    # Returns the version of the Podspec.
    #
    # @return [String] The version of the Podspec.
    attr_reader :version

    # Returns the authors of the Podspec.
    #
    # @return [Array<String>] The authors of the Podspec.
    attr_reader :authors

    # Returns the source of the Podspec.
    #
    # @return [String] The source of the Podspec.
    attr_reader :source
  end

  # Represents a parser for Podspec files.
  class PodspecParser
    # Initializes a new instance of PodspecParser.
    #
    # @param path [String] The path to the Podspec file to be parsed.
    def initialize(path)
      @path = path
    end

    # Parses the Podspec file at the given path and returns a Podspec object.
    #
    # @return [Podspec] A Podspec object representing the parsed Podspec file.
    #
    # @raise [Pod::DSLError] If there is an error parsing the Podspec file.
    def parse
      # Parse the Podspec file using CocoaPods' Pod::Specification.
      podspec = Pod::Specification.from_file(@path)

      # Create a new Podspec object with the parsed data.
      @podspec = Podspec.new(
        @path,
        podspec.name,
        podspec.version.version,
        podspec.authors.nil? ? podspec.author : podspec.authors,
        podspec.source
      )
    end
  end
end
