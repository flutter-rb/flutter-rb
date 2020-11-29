require_relative 'check'
require_relative '../report/check_report'
require_relative '../report/check_report_status'

require 'yaml'

module FlutterRb
  class PluginPubspecCheck < Check
    def name
      "PluginPubspec#{pubspec_parameter.capitalize}Check"
    end

    def pubspec_parameter
      UNIMPLEMENTATION_ERROR
    end

    def summary
      "Validate Flutter plugin's #{pubspec_parameter} in pubspec.yaml"
    end

    def check(project)
      pubspec = project.pubspec
      CheckReport.new(
        name,
        pubspec[pubspec_parameter].nil? ? not_normal_status : CheckReportStatus::NORMAL,
        description
      )
    end
  end

  class PluginPubspecWarningCheck < PluginPubspecCheck
    def not_normal_status
      CheckReportStatus::WARNING
    end
  end

  class PluginPubspecErrorCheck < PluginPubspecCheck
    def not_normal_status
      CheckReportStatus::ERROR
    end
  end

  class PluginPubspecNameCheck < PluginPubspecErrorCheck
    def pubspec_parameter
      'name'
    end
  end

  class PluginPubspecDescriptionCheck < PluginPubspecWarningCheck
    def pubspec_parameter
      'description'
    end
  end

  class PluginPubspecVersionCheck < PluginPubspecErrorCheck
    def pubspec_parameter
      'version'
    end
  end

  class PluginPubspecAuthorCheck < PluginPubspecWarningCheck
    def pubspec_parameter
      'author'
    end
  end

  class PluginPubspecHomepageCheck < PluginPubspecErrorCheck
    def pubspec_parameter
      'homepage'
    end
  end
end
