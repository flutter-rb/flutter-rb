require_relative './flutter_rb/project/project'
require_relative './flutter_rb/checks/plugin_directories_check'
require_relative './flutter_rb/checks/plugin_pubspec_check'
require_relative './flutter_rb/checks/plugin_gradle_check'
require_relative './flutter_rb/checks/plugin_podspec_check'
require_relative './flutter_rb/config/flutter_rb_config_initializer'

require_relative './checkstyle_report/checkstyle_report'

module FlutterRb
  # Start FlutterRb checks
  class FlutterRb
    def start(path, with_report)
      project = ProjectParser.new(path).project
      if project.nil?
        exit_with_no_project
      else
        check_project(
          project,
          path,
          with_report
        )
      end
    end

    def exit_with_no_project
      puts 'No project'
      exit(-1)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def check_project(project, path, with_report)
      config_initializer = FlutterRbConfigInitializer.new
      config_path = "#{path}/.flutter_rb.yaml"
      config = File.exist?(config_path) ? config_initializer.parse(config_path) : config_initializer.default
      checks = explore_project(
        project,
        config.flutter_checks,
        config.android_checks,
        config.ios_checks
      )
      checks.each { |check| puts check.print }
      errors = checks.reject { |check| check.check_report_status == CheckReportStatus::NORMAL }
      create_report(path, checks) if with_report
      exit(errors.empty? ? 0 : -1)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def explore_project(
      project,
      flutter_checks,
      android_checks,
      ios_checks
    )
      result = []
      result += flutter_checks.map { |check| check.check(project) }
      result += android_checks.map { |check| check.check(project) } unless project.android_folder.nil?
      result += ios_checks.map { |check| check.check(project) } unless project.ios_folder.nil?
      result
    end

    # rubocop:disable Metrics/MethodLength
    def create_report(path, checks)
      errors = checks.map do |check|
        CheckstyleReport::CheckstyleError.new(
          level_for_report(check.check_report_status),
          check.message,
          check.path,
          0,
          0,
          check.check_name
        )
      end
      CheckstyleReport::CheckstyleReport.new(
        path,
        'frb-checkstyle-report',
        errors
      ).create_report
    end
    # rubocop:enable Metrics/MethodLength

    def level_for_report(check_report_status)
      case check_report_status
      when CheckReportStatus::NORMAL
        CheckstyleReport::CheckstyleError::SEVERITY_NORMAL
      when CheckReportStatus::WARNING
        CheckstyleReport::CheckstyleError::SEVERITY_WARNING
      when CheckReportStatus::ERROR
        CheckstyleReport::CheckstyleError::SEVERITY_ERROR
      else
        throw 'Unknown CheckReportStatus'
      end
    end
  end
end
