require_relative './flutter-rb/project/project_parser'
require_relative './flutter-rb/checks/plugin_directories_check'
require_relative './flutter-rb/checks/plugin_pubspec_check'
require_relative './flutter-rb/report/check_report_status'

module FlutterRb
  # Start FlutterRb checks
  class FlutterRb
    @@checks = [
      PluginDirectoriesCheck.new,
      PluginPubspecNameCheck.new,
      PluginPubspecDescriptionCheck.new,
      PluginPubspecVersionCheck.new,
      PluginPubspecAuthorCheck.new,
      PluginPubspecHomepageCheck.new
    ]

    def start(path)
      project = ProjectParser.new(path).project
      if project.nil?
        puts 'No project'
        exit(-1)
      else
        result = @@checks.map { |check| check.check(project) }.select { |report| 
          report.check_report_status != CheckReportStatus::NORMAL
        }
        result.each { |report| puts report.print }
        exit(result.empty? ? 0 : -1)
      end
    end
  end
end
