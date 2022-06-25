require_relative './flutter_rb_config'

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

    def initialize(path)
      @path = path
    end

    # rubocop:disable Metrics/AbcSize
    def parse(path)
      config = YAML.load_file(path)['include']
      flutter_checks = config['flutter'].include? config['flutter'].map(&:new)
      android_checks = config['android'].include? config['android'].map(&:new)
      ios_checks = config['ios'].include? config['ios'].map(&:new)
      FlutterRbConfig.new(
        flutter_checks.empty? ? FLUTTER_CHECKS : flutter_checks,
        android_checks.empty? ? ANDROID_CHECKS : android_checks,
        ios_checks.empty? ? IOS_CHECKS : ios_checks
      )
    end
    # rubocop:enable Metrics/AbcSize

    def default
      FlutterRbConfig.new(
        FLUTTER_CHECKS,
        ANDROID_CHECKS,
        IOS_CHECKS
      )
    end
  end
end
