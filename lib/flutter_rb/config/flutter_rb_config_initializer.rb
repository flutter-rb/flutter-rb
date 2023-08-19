require_relative './flutter_rb_config'
require_relative '../checks/plugin_directories_check'

require 'yaml'

module FlutterRb
  # Class that initialize configuration
  class FlutterRbConfigInitializer
    FLUTTER_CHECKS = [
      PluginDirectoriesCheck.new,
      PluginPubspecNameCheck.new,
      PluginPubspecDescriptionCheck.new,
      PluginPubspecVersionCheck.new,
      PluginPubspecAuthorCheck.new,
      PluginPubspecHomepageCheck.new,
      PluginPubspecEffectiveDartCheck.new
    ].freeze

    ANDROID_CHECKS = [
      PluginGradleAndroidPackageCheck.new,
      PluginGradleVersionCheck.new
    ].freeze

    IOS_CHECKS = [
      PluginPodspecNameCheck.new,
      PluginPodspecVersionCheck.new,
      PluginPodspecAuthorsCheck.new,
      PluginPodspecSourceCheck.new
    ].freeze

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    # @param {String} path
    def parse(path)
      config = YAML.load_file(path)['include']
      flutter_checks = []
      unless config['flutter'].nil?
        flutter_checks += config['flutter'].map do |check|
          Object.const_get("FlutterRb::#{check}").new
        end
      end
      android_checks = []
      unless config['android'].nil?
        android_checks += config['android'].map do |check|
          Object.const_get("FlutterRb::#{check}").new
        end
      end
      ios_checks = []
      unless config['ios'].nil?
        ios_checks += config['ios'].map do |check|
          Object.const_get("FlutterRb::#{check}").new
        end
      end
      FlutterRbConfig.new(
        flutter_checks.empty? ? FLUTTER_CHECKS : flutter_checks,
        android_checks.empty? ? ANDROID_CHECKS : android_checks,
        ios_checks.empty? ? IOS_CHECKS : ios_checks
      )
    end

    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

    # @return {FlutterRbConfig}
    def default
      FlutterRbConfig.new(
        FLUTTER_CHECKS,
        ANDROID_CHECKS,
        IOS_CHECKS
      )
    end
  end
end
