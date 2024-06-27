# frozen_string_literal: true

require_relative './flutter_rb/project/project'
require_relative './flutter_rb/checks/plugin_directories_check'
require_relative './flutter_rb/checks/plugin_pubspec_check'
require_relative './flutter_rb/checks/plugin_gradle_check'
require_relative './flutter_rb/checks/plugin_podspec_check'
require_relative './flutter_rb/config/flutter_rb_config_initializer'

require_relative './checkstyle_report/checkstyle_report'

module FlutterRb
  # FlutterRb entry
  class FlutterRb
    # Start FlutterRb checks
    # @param {String} path
    # @param {Boolean} with_report
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

    # @return {Void}
    def exit_with_no_project
      puts 'No project'
      exit(-1)
    end

    # @param {Project} project
    # @param {String} path
    # @param {Bool} with_report
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
      errors = checks.reject do |check|
        check.check_report_status == CheckReportStatus::NORMAL
      end
      create_report(path, checks) if with_report
      exit(errors.empty? ? 0 : -1)
    end

    # @param {Project} project
    # @param {Check[]} flutter_checks
    # @param {Check[]} android_checks
    # @param {Check[]} ios_checks
    def explore_project(project, flutter_checks, android_checks, ios_checks)
      result = []
      result += flutter_checks.map do |check|
        check.check(project)
      end
      unless project.android_folder.nil?
        result += android_checks.map do |check|
          check.check(project)
        end
      end
      unless project.ios_folder.nil?
        result += ios_checks.map do |check|
          check.check(project)
        end
      end
      result
    end

    # @param {String} path
    # @param {Check[]} checks
    # @return {CheckstyleReport}
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

    # @return {CheckstyleReport}
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
