# frozen_string_literal: true

require_relative './pubspec_info'
require_relative './dev_dependency'
require_relative './platform_plugin'

module FlutterRb
  # pubspec.yaml representation
  class Pubspec
    # @param {String} path
    # @param {PubspecInfo} pubspec_info
    # @param {DevDependency[]} dev_dependencies
    # @param {PlatformPlugin[]} platform_plugins
    def initialize(path, pubspec_info, dev_dependencies, platform_plugins)
      @path = path
      @pubspec_info = pubspec_info
      @dev_dependencies = dev_dependencies
      @platform_plugins = platform_plugins
    end

    attr_reader :path, :pubspec_info, :dev_dependencies, :platform_plugins
  end

  # pubspec.yaml parser
  class PubspecParser
    # @param {String} path
    # @param {Pubspec} pubspec
    def initialize(path, pubspec)
      @path = path
      @pubspec = pubspec
    end

    # @return {Pubspec}
    def parse
      Pubspec.new(
        @path,
        pubspec_info(@pubspec),
        dev_dependencies(@pubspec),
        platform_plugins(@pubspec)
      )
    end

    # @param {Pubspec}
    # @return {PubspecInfo}
    def pubspec_info(pubspec)
      PubspecInfo.new(
        pubspec['name'],
        pubspec['description'],
        pubspec['version'],
        pubspec['author'],
        pubspec['homepage']
      )
    end

    # @param {Pubspec} pubspec
    # @return {DevDependency[]}
    def dev_dependencies(pubspec)
      pubspec['dev_dependencies']&.map do |dev_dependency|
        DevDependency.new(
          dev_dependency.first,
          dev_dependency.last
        )
      end
    end

    # @param {Pubspec} pubspec
    # @return {PlatformPlugin[]}
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
