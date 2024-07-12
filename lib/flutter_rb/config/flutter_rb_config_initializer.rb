# frozen_string_literal: true

require_relative './flutter_rb_config'
require_relative '../checks/plugin_directories_check'

require 'yaml'

module FlutterRb
  # This class is responsible for initializing a FlutterRbConfig object.
  class FlutterRbConfigInitializer
    # An array of Flutter checks to be performed.
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

    # An array of Android checks to be performed.
    ANDROID_CHECKS = [
      PluginGradleAndroidPackageCheck.new,
      PluginGradleVersionCheck.new
    ].freeze

    # An array of iOS checks to be performed.
    IOS_CHECKS = [
      PluginPodspecNameCheck.new,
      PluginPodspecVersionCheck.new,
      PluginPodspecAuthorsCheck.new,
      PluginPodspecSourceCheck.new
    ].freeze

    # Parses a YAML configuration file and initializes a FlutterRbConfig object.
    #
    # @param path [String] The path to the YAML configuration file.
    # @return [FlutterRbConfig] A FlutterRbConfig object initialized with the parsed configuration.
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

    # Initializes a FlutterRbConfig object with the default checks.
    #
    # @return [FlutterRbConfig] A FlutterRbConfig object initialized with the default checks.
    def default
      FlutterRbConfig.new(
        FLUTTER_CHECKS,
        ANDROID_CHECKS,
        IOS_CHECKS
      )
    end
  end
end
