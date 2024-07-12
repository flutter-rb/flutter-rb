# frozen_string_literal: true

require_relative './pubspec_info'
require_relative './dev_dependency'
require_relative './platform_plugin'

module FlutterRb
  # Represents a parsed pubspec.yaml file.
  class Pubspec
    # Initializes a new instance of Pubspec.
    #
    # @param path [String] The path to the pubspec.yaml file.
    # @param pubspec_info [PubspecInfo] The parsed information from the pubspec.yaml file.
    # @param dev_dependencies [Array<DevDependency>] An array of parsed dev dependencies.
    # @param platform_plugins [Array<PlatformPlugin>] An array of parsed platform plugins.
    def initialize(path, pubspec_info, dev_dependencies, platform_plugins)
      @path = path
      @pubspec_info = pubspec_info
      @dev_dependencies = dev_dependencies
      @platform_plugins = platform_plugins
    end

    # Returns the path to the pubspec.yaml file.
    #
    # @return [String] The path to the pubspec.yaml file.
    attr_reader :path

    # Returns the parsed information from the pubspec.yaml file.
    #
    # @return [PubspecInfo] The parsed information from the pubspec.yaml file.
    attr_reader :pubspec_info

    # Returns an array of parsed dev dependencies.
    #
    # @return [Array<DevDependency>] An array of parsed dev dependencies.
    attr_reader :dev_dependencies

    # Returns an array of parsed platform plugins.
    #
    # @return [Array<PlatformPlugin>] An array of parsed platform plugins.
    attr_reader :platform_plugins
  end

  # This class is responsible for parsing a pubspec.yaml file and creating a Pubspec object.
  class PubspecParser
    # Initializes a new instance of PubspecParser.
    #
    # @param path [String] The path to the pubspec.yaml file.
    # @param pubspec [Hash] The parsed pubspec.yaml file as a Hash.
    def initialize(path, pubspec)
      @path = path
      @pubspec = pubspec
    end

    # Parses the pubspec.yaml file and creates a Pubspec object.
    #
    # @return [Pubspec] The parsed Pubspec object.
    def parse
      Pubspec.new(
        @path,
        pubspec_info(@pubspec),
        dev_dependencies(@pubspec),
        platform_plugins(@pubspec)
      )
    end

    # Parses the pubspec.yaml file and extracts the general information.
    #
    # @param pubspec [Hash] The parsed pubspec.yaml file as a Hash.
    # @return [PubspecInfo] The parsed PubspecInfo object.
    def pubspec_info(pubspec)
      PubspecInfo.new(
        pubspec['name'],
        pubspec['description'],
        pubspec['version'],
        pubspec['author'],
        pubspec['homepage']
      )
    end

    # Parses the pubspec.yaml file and extracts the dev dependencies.
    #
    # @param pubspec [Hash] The parsed pubspec.yaml file as a Hash.
    # @return [Array<DevDependency>] An array of parsed DevDependency objects.
    def dev_dependencies(pubspec)
      pubspec['dev_dependencies']&.map do |dev_dependency|
        DevDependency.new(
          dev_dependency.first,
          dev_dependency.last
        )
      end
    end

    # Parses the pubspec.yaml file and extracts the platform plugins.
    #
    # @param pubspec [Hash] The parsed pubspec.yaml file as a Hash.
    # @return [Array<PlatformPlugin>] An array of parsed PlatformPlugin objects.
    def platform_plugins(pubspec)
      pubspec.dig('flutter', 'plugin', 'platforms')&.map do |platform_plugin|
        plugin_info = platform_plugin.last

        PlatformPlugin.new(
          plugin_info['package'],
          plugin_info['pluginClass'],
          platform_plugin.first == Platform::ANDROID ? Platform::ANDROID : Platform::IOS
        )
      end
    end
  end
end
