# frozen_string_literal: true

module FlutterRb
  # Represents a Flutter platform plugin.
  class PlatformPlugin
    # Initializes a new instance of PlatformPlugin.
    #
    # @param platform [String] The platform this plugin is for.
    # @param package [String] The package name of the plugin.
    # @param plugin_class [String] The class name of the plugin.
    def initialize(platform, package, plugin_class)
      @platform = platform
      @package = package
      @plugin_class = plugin_class
    end

    # Returns the platform this plugin is for.
    #
    # @return [String] The platform.
    attr_reader :platform

    # Returns the package name of the plugin.
    #
    # @return [String] The package name.
    attr_reader :package

    # Returns the class name of the plugin.
    #
    # @return [String] The class name.
    attr_reader :plugin_class
  end

  # Represents a platform in Flutter.
  class Platform
    # The Android platform constant.
    ANDROID = 'android'

    # The iOS platform constant.
    IOS = 'ios'
  end
end
