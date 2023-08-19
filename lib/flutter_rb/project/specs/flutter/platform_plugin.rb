module FlutterRb
  # Flutter plugin, contains platform, package and plugin class
  class PlatformPlugin
    # @param {String} platform
    # @param {String} package
    # @param {String} plugin_class
    def initialize(platform, package, plugin_class)
      @platform = platform
      @package = package
      @plugin_class = plugin_class
    end

    attr_reader :platform, :package, :plugin_class
  end

  # Supported platforms for this tool
  class Platform
    ANDROID = 'android'.freeze
    IOS = 'ios'.freeze
  end
end
