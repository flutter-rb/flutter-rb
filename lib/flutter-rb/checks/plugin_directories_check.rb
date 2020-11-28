require_relative 'check'
require_relative '../report/check_report'
require_relative '../report/check_report_status'

module FlutterRb
  # Check for Flutter plugin structure validation
  class PluginDirectoriesCheck < Check
    def name
      'PluginDirectoriesCheck'
    end

    def info
      'Validate Flutter plugin structure'
    end

    def check(plugin_root)
      android_exists = File.exist?("#{plugin_root}/android")
      ios_exists = File.exist?("#{plugin_root}/ios")

      check_result = android_exists && ios_exists || !android_exists && !ios_exists
      check_report_status = check_result ? CheckReportStatus::NORMAL : CheckReportStatus::ERROR
      CheckReport.new(
        name,
        check_report_status,
        'No provided'
      )
    end
  end
end
