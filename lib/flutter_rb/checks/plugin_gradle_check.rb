# frozen_string_literal: true

require_relative './check'
require_relative '../report/check_report'

module FlutterRb
  # This class represents a check for validating that the 'android' package
  # does not exist in the Gradle project configuration.
  class PluginGradleAndroidPackageCheck < Check
    # Returns the name of the check.
    #
    # @return [String] The name of the check.
    def name
      'PluginGradleAndroidPackageCheck'
    end

    # Returns the description of the check.
    #
    # @return [String] The description of the check.
    def description
      'Validate that \android\ package not exists in Gradle project config (build.gradle file)'
    end

    # Performs the check on the given project.
    #
    # @param project [Project] The project to perform the check on.
    # @return [CheckReport] The report of the check result.
    def check(project)
      # Get the Gradle configuration file.
      gradle = project.android_folder.gradle

      # Check if the 'package android' line exists in the build.gradle file.
      import_exist = File.readlines("#{gradle.path}/build.gradle").grep(/package android/).size.positive?

      # Create a check report based on the result.
      CheckReport.new(
        name,
        import_exist ? ::CheckReportStatus::ERROR : ::CheckReportStatus::NORMAL,
        description,
        gradle.path
      )
    end
  end

  # This class represents a check for validating the version of the plugin in the Gradle project configuration.
  class PluginGradleVersionCheck < Check
    # Returns the name of the check.
    #
    # @return [String] The name of the check.
    def name
      'PluginGradleVersionCheck'
    end

    # Returns the description of the check.
    #
    # @return [String] The description of the check.
    def description
      'Check plugin version in Gradle project config (build.gradle file)'
    end

    # Performs the check on the given project.
    #
    # @param project [Project] The project to perform the check on.
    # @return [CheckReport] The report of the check result.
    def check(project)
      # Get the version of the plugin from the pubspec file.
      version_in_pubspec = project.pubspec.pubspec_info.version

      # Get the Gradle configuration file.
      gradle = project.android_folder.gradle

      # Get the version of the plugin from the Gradle build file.
      version_in_gradle = gradle.version

      # Create a check report based on the result.
      CheckReport.new(
        name,
        version_in_pubspec == version_in_gradle ? ::CheckReportStatus::NORMAL : ::CheckReportStatus::WARNING,
        description,
        gradle.path
      )
    end
  end
end
