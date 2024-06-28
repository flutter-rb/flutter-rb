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
    # This class is the entry point for FlutterRb checks.
    # It provides methods to start the checks, handle project parsing,
    # explore project directories, create reports, and handle exit codes.

    # Start FlutterRb checks
    #
    # @param path [String] The path to the Flutter project directory
    # @param with_report [Boolean] Whether to generate a report or not
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

    # Exit the program with a message indicating no project found
    #
    # @return [Void]
    def exit_with_no_project
      puts 'No project'

      exit(-1)
    end

    # Check the Flutter project
    #
    # @param project [Project] The parsed Flutter project
    # @param path [String] The path to the Flutter project directory
    # @param with_report [Boolean] Whether to generate a report or not
    # @return [Void]
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

    # Explore the Flutter project directories and perform checks
    #
    # @param project [Project] The parsed Flutter project
    # @param flutter_checks [Check[]] The checks to perform on the Flutter project
    # @param android_checks [Check[]] The checks to perform on the Android project
    # @param ios_checks [Check[]] The checks to perform on the iOS project
    # @return [Check[]] The results of the performed checks
    def explore_project(project, flutter_checks, android_checks, ios_checks)
      result = []
      result += flutter_checks.map { |check| check.check(project) }
      result += android_checks.map { |check| check.check(project) } unless project.android_folder.nil?
      result += ios_checks.map { |check| check.check(project) } unless project.ios_folder.nil?

      result
    end

    # Create a report based on the performed checks
    #
    # @param path [String] The path to the Flutter project directory
    # @param checks [Check[]] The results of the performed checks
    # @return [CheckstyleReport] The created report
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

    # Determine the severity level for a check report status
    #
    # @param check_report_status [CheckReportStatus] The status of the check report
    # @return [CheckstyleReport] The severity level for the report
    def level_for_report(check_report_status)
      case check_report_status
      when CheckReportStatus::NORMAL
        ::CheckstyleError::SEVERITY_NORMAL
      when CheckReportStatus::WARNING
        ::CheckstyleError::SEVERITY_WARNING
      when CheckReportStatus::ERROR
        ::CheckstyleError::SEVERITY_ERROR
      else
        throw 'Unknown CheckReportStatus'
      end
    end
  end
end
