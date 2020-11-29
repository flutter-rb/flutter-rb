require_relative 'check'
require_relative '../report/check_report'
require_relative '../report/check_report_status'

module FlutterRb
  # Check for Flutter plugin structure validation
  class PluginDirectoriesCheck < Check
    def name
      'PluginDirectoriesCheck'
    end

    def summary
      'Validate Flutter plugin structure'
    end

    def check(project)
      android_exists = project.android_folder.exists
      ios_exists = project.ios_folder.exists

      check_result = android_exists && ios_exists || !android_exists && !ios_exists
      CheckReport.new(
        name,
        check_result ? CheckReportStatus::NORMAL : CheckReportStatus::ERROR,
        description
      )
    end
  end
end
