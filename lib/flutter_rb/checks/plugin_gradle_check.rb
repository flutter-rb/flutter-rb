require_relative './check'
require_relative '../report/check_report'

module FlutterRb
  # Check 'android; import not exists in Gradle project config (build.gradle file)
  class PluginGradleAndroidPackageCheck < Check
    def name
      'PluginGradleAndroidPackageCheck'
    end

    def summary
      'Validate that \android\ package not exists in build.gradle config'
    end

    def description
      'Validate that \android\ package not exists in Gradle project config (build.gradle file)'
    end

    def check(project)
      gradle = project.android_folder.gradle
      import_exist = File.readlines(gradle.path).grep(/package android/).size.positive?
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
    def name
      'PluginGradleVersionCheck'
    end

    def summary
      'Validate Flutter plugin\s version in build.gradle file'
    end

    def description
      'Check plugin version in Gradle project config (build.gradle file)'
    end

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
