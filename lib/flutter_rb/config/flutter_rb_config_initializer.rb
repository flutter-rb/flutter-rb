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
      config = YAML.load_file(path)

      exclude_flutter_checks = []
      exclude_android_checks = []
      exclude_ios_checks = []

      unless config.nil?
        exclude_checks = YAML.load_file(path)['exclude']

        unless exclude_checks['flutter'].nil?
          exclude_flutter_checks += exclude_checks['flutter'].map { |check| "FlutterRb::#{check}" }
        end

        unless exclude_checks['android'].nil?
          exclude_android_checks += exclude_checks['android'].map { |check| "FlutterRb::#{check}" }
        end

        unless exclude_checks['ios'].nil?
          exclude_ios_checks += exclude_checks['ios'].map { |check| "FlutterRb::#{check}" }
        end
      end

      FlutterRbConfig.new(
        FLUTTER_CHECKS.reject { |check| exclude_flutter_checks&.include?(check.class.name) },
        ANDROID_CHECKS.reject { |check| exclude_android_checks&.include?(check.class.name) },
        IOS_CHECKS.reject { |check| exclude_ios_checks&.include?(check.class.name) }
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
