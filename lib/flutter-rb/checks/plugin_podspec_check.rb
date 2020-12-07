require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # Base class for all info parameters in Flutter plugin's podspec file
  class PluginPodspecCheck < Check
    def name
      "PluginPodspec#{podspec_parameter.capitalize}Check"
    end

    def podspec_parameter
      UNIMPLEMENTATION_ERROR
    end

    def summary
      "Validate Flutter plugin's #{podspec_parameter} in podspec file"
    end
  end

  # Check Flutter plugin's name in podspec file
  class PluginPodspecNameCheck < PluginPodspecCheck
    def podspec_parameter
      'name'
    end

    def check(project)
      name_in_pubspec = project.pubspec.pubspec_info.name
      name_in_podspec = project.ios_folder.podspec.name
      CheckReport.new(
        name,
        name_in_pubspec == name_in_podspec ? CheckReportStatus::NORMAL : CheckReportStatus::WARNING,
        description
      )
    end
  end

  # Check Flutter plugin's version in podspec file
  class PluginPodspecVersionCheck < PluginPodspecCheck
    def podspec_parameter
      'version'
    end

    def check(project)
      version_in_pubspec = project.pubspec.pubspec_info.version
      version_in_podspec = project.ios_folder.podspec.version
      CheckReport.new(
        name,
        version_in_pubspec == version_in_podspec ? CheckReportStatus::NORMAL : CheckReportStatus::WARNING,
        description
      )
    end
  end

  # Check Flutter plugin's source in podspec file
  class PluginPodspecSourceCheck < PluginPodspecCheck
    def podspec_parameter
      'source'
    end

    def check(project)
      CheckReport.new(
        name,
        project.ios_folder.podspec.source.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description
      )
    end
  end
end
