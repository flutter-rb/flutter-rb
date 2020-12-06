require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # Check Flutter plugin's structure validation
  class PluginDirectoriesCheck < Check
    def name
      'PluginDirectoriesCheck'
    end

    def summary
      'Validate Flutter plugin structure'
    end

    def check(project)
      android_exists = !project.android_folder.nil?
      ios_exists = !project.ios_folder.nil?

      check_result = android_exists && ios_exists || !android_exists && !ios_exists
      CheckReport.new(
        name,
        check_result ? CheckReportStatus::NORMAL : CheckReportStatus::ERROR,
        description
      )
    end
  end
end
