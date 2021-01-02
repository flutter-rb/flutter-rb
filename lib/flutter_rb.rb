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
        puts 'No project'
        exit(-1)
      else
        issues = find_issues(project)
        create_report(path, issues) if with_report
        issues.each { |issue| puts issue.print }
        exit(issues.empty? ? 0 : -1)
      end
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
      errors = issues.reject { |issue| issue.check_report_status == CheckReportStatus::NORMAL }.map do |issue|
        CheckstyleReport::CheckstyleError.new(
          level_for_report(issue.check_report_status),
          issue.message,
          '',
          0,
          0,
          issue.check_name
        )
      end
      CheckstyleReport::CheckstyleReport.new(
        path,
        'flutter_rb-report',
        errors
      ).create_report
    end
    # rubocop:enable Metrics/MethodLength

    def level_for_report(check_report_status)
      case check_report_status
      when CheckReportStatus::ERROR
        'error'
      when CheckReportStatus::WARNING
        'warning'
      end
    end

    def flutter_checks(project, exclude_normal: true)
      reports = FlutterRb::FLUTTER_CHECKS.map { |check| check.check(project) }
      if exclude_normal
        reports.reject { |report| report.check_report_status == CheckReportStatus::NORMAL }
      else
        reports
      end
    end

    def android_checks(project, exclude_normal: true)
      if project.android_folder.nil?
        []
      else
        reports = FlutterRb::ANDROID_CHECKS.map { |check| check.check(project) }
        if exclude_normal
          reports.reject { |report| report.check_report_status == CheckReportStatus::NORMAL }
        else
          reports
        end
      end
    end

    def ios_checks(project, exclude_normal: true)
      if project.ios_folder.nil?
        []
      else
        reports = FlutterRb::IOS_CHECKS.map { |check| check.check(project) }
        if exclude_normal
          reports.reject { |report| report.check_report_status == CheckReportStatus::NORMAL }
        else
          reports
        end
      end
    end
  end
end
