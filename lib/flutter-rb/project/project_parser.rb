require_relative './project'
require_relative './specs/flutter/pubspec'
require_relative './specs/flutter/dev_dependency'
require_relative './specs/flutter/platform_plugin'
require_relative './specs/android/android_folder'
require_relative './specs/android/gradle_config'
require_relative './specs/ios/ios_folder'

require 'yaml'

module FlutterRb
  # Flutter plugin project parser
  class ProjectParser
    def initialize(path)
      @path = path
    end

    def project
      pubspec_path = "#{@path}/pubspec.yaml"
      android_path = "#{@path}/android"
      ios_path = "#{@path}/ios"
      if File.exist?(pubspec_path)
        return Project.new(
          PubspecParser.new(YAML.load_file(pubspec_path)).parse,
          File.exist?(android_path) ? AndroidFolder.new(GradleConfig.new) : nil,
          File.exist?(ios_path) ? IOSFolder.new(ios_path) : nil
        )
      end
      nil
    end
  end
end
