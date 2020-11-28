require_relative './flutter-rb/checks/plugin_directories_check'
require_relative './flutter-rb/checks/plugin_pubspec_check'
require_relative './flutter-rb/report/check_report_status'

module FlutterRb
  # Start FlutterRb checks
  class FlutterRb
    @@checks = [
      PluginDirectoriesCheck.new,
      PluginPubspecCheck.new
    ]

    def start(path)
      result = @@checks.map { |check| check.check(path) }.select { |report| 
        report.check_report_status != CheckReportStatus::NORMAL
      }
      result.each { |report| puts report.print }
    end
  end
end
