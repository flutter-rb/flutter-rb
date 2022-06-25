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

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Layout/LineLength
    def parse(path)
      config = YAML.load_file(path)['include']
      flutter_checks = []
      flutter_checks += config['flutter'].map { |check| Object.const_get("FlutterRb::#{check}").new } unless config['flutter'].nil?
      android_checks = []
      android_checks += config['android'].map { |check| Object.const_get("FlutterRb::#{check}").new } unless config['android'].nil?
      ios_checks = []
      ios_checks += config['ios'].map { |check| Object.const_get("FlutterRb::#{check}").new } unless config['ios'].nil?
      FlutterRbConfig.new(
        flutter_checks.empty? ? FLUTTER_CHECKS : flutter_checks,
        android_checks.empty? ? ANDROID_CHECKS : android_checks,
        ios_checks.empty? ? IOS_CHECKS : ios_checks
      )
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Layout/LineLength

    def default
      FlutterRbConfig.new(
        FLUTTER_CHECKS,
        ANDROID_CHECKS,
        IOS_CHECKS
      )
    end
  end
end
