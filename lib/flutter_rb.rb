require_relative './flutter_rb/project/project'
require_relative './flutter_rb/checks/plugin_directories_check'
require_relative './flutter_rb/checks/plugin_pubspec_check'
require_relative './flutter_rb/checks/plugin_gradle_check'
require_relative './flutter_rb/checks/plugin_podspec_check'

require_relative './checkstyle_report/checkstyle_report'

module FlutterRb
  # Start FlutterRb checks
  class FlutterRb
    FLUTTER_CHECKS = [
      PluginDirectoriesCheck.new,
      PluginPubspecNameCheck.new,
      PluginPubspecDescriptionCheck.new,
      PluginPubspecVersionCheck.new,
      PluginPubspecAuthorCheck.new,
      PluginPubspecHomepageCheck.new,
      PluginPubspecEffectiveDartCheck.new
    ].freeze

    ANDROID_CHECKS = [
      PluginGradleVersionCheck.new
    ].freeze

    IOS_CHECKS = [
      PluginPodspecNameCheck.new,
      PluginPodspecVersionCheck.new,
      PluginPodspecAuthorsCheck.new,
      PluginPodspecSourceCheck.new
    ].freeze

    def start(path, with_report)
      project = ProjectParser.new(path).project
      if project.nil?
        exit_with_no_project
      else
        start_checks(project, path, with_report)
      end
    end

    def exit_with_no_project
      puts 'No project'
      exit(-1)
    end

    def start_checks(project, path, with_report)
      issues = find_issues(project)
      create_report(path, issues) if with_report
      issues.reject { |issue| issue.check_report_status == CheckReportStatus::NORMAL }.each { |issue| puts issue.print }
      exit(issues.empty? ? 0 : -1)
    end

    def find_issues(project)
      result = []
      result += flutter_checks(project)
      result += android_checks(project)
      result += ios_checks(project)
      result
    end

    # rubocop:disable Metrics/MethodLength
    def create_report(path, issues)
      errors = issues.map do |issue|
        CheckstyleReport::CheckstyleError.new(
          level_for_report(issue.check_report_status),
          issue.message,
          issue.path,
          0,
          0,
          issue.check_name
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
        CheckstyleReport::CheckstyleError::SAVERITY_NORMAL
      when CheckReportStatus::WARNING
        CheckstyleReport::CheckstyleError::SAVERITY_WARNING
      when CheckReportStatus::ERROR
        CheckstyleReport::CheckstyleError::SAVERITY_ERROR
      end
    end

    def flutter_checks(project)
      FlutterRb::FLUTTER_CHECKS.map { |check| check.check(project) }
    end

    def android_checks(project)
      if project.android_folder.nil?
        []
      else
        FlutterRb::ANDROID_CHECKS.map { |check| check.check(project) }
      end
    end

    def ios_checks(project)
      if project.ios_folder.nil?
        []
      else
        FlutterRb::IOS_CHECKS.map { |check| check.check(project) }
      end
    end
  end
end
