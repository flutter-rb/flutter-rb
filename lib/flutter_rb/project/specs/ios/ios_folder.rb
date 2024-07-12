# frozen_string_literal: true

require_relative './podspec'

module FlutterRb
  # Represents the iOS folder structure and its associated podspec file.
  class IOSFolder
    # Initializes a new instance of IOSFolder.
    #
    # @param path [String] The path to the iOS folder.
    # @param pubspec [Pubspec] The parsed pubspec information.
    #
    # @return [IOSFolder] A new instance of IOSFolder.
    def initialize(path, pubspec)
      @path = path
      # Construct the path to the podspec file.
      podspec_path = "#{path}/#{pubspec.pubspec_info.name}.podspec"
      # If the podspec file exists, parse it; otherwise, set @podspec to nil.
      @podspec = File.exist?(podspec_path) ? PodspecParser.new(podspec_path).parse : nil
    end

    # Returns the path to the iOS folder.
    #
    # @return [String] The path to the iOS folder.
    attr_reader :path

    # Returns the parsed podspec information.
    #
    # @return [Podspec, nil] The parsed podspec information, or nil if the podspec file does not exist.
    attr_reader :podspec
  end
end
