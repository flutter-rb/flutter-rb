# frozen_string_literal: true

require_relative './check'
require_relative '../report/check_report'

module FlutterRb
  # Check 'android; import not exists in Gradle project config (build.gradle file)
  class PluginGradleAndroidPackageCheck < Check
    # @return {String}
    def name
      'PluginGradleAndroidPackageCheck'
    end

    # @return {String}
    def summary
      'Validate that \android\ package not exists in build.gradle config'
    end

    # @return {String}
    def description
      'Validate that \android\ package not exists in Gradle project config (build.gradle file)'
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      gradle = project.android_folder.gradle
      import_exist = File.readlines("#{gradle.path}/build.gradle").grep(/package android/).size.positive?
      CheckReport.new(
        name,
        import_exist ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        gradle.path
      )
    end
  end

  # Check Flutter plugin version in Gradle project config (build.gradle file)
  class PluginGradleVersionCheck < Check
    # @return {String}
    def name
      'PluginGradleVersionCheck'
    end

    # @return {String}
    def summary
      'Validate Flutter plugin\s version in build.gradle file'
    end

    # @return {String}
    def description
      'Check plugin version in Gradle project config (build.gradle file)'
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      version_in_pubspec = project.pubspec.pubspec_info.version
      gradle = project.android_folder.gradle
      version_in_gradle = gradle.version
      CheckReport.new(
        name,
        version_in_pubspec == version_in_gradle ? CheckReportStatus::NORMAL : CheckReportStatus::WARNING,
        description,
        gradle.path
      )
    end
  end
end
