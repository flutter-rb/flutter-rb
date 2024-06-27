# frozen_string_literal: true

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
      PluginPubspecLintsCheck.new,
      PluginPubspecFlutterLintsCheck.new
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

    # @param {String} path
    # @return {FlutterRbConfig}
    def parse(path)
      config = YAML.load_file(path)

      exclude_flutter_checks = ::Set.new
      exclude_android_checks = ::Set.new
      exclude_ios_checks = ::Set.new

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
