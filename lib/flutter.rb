require_relative './flutter-rb/project/project_parser'
require_relative './flutter-rb/checks/plugin_directories_check'
require_relative './flutter-rb/checks/plugin_pubspec_check'
require_relative './flutter-rb/checks/plugin_podspec_check'

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
      # PluginPubspecPlatformDeclarationCheck.new,
      PluginPubspecEffectiveDartCheck.new
    ].freeze

    IOS_CHECKS = [
      PluginPodspecNameCheck.new,
      PluginPodspecVersionCheck.new,
      PluginPubspecDescriptionCheck.new,
      PluginPodspecHomepageCheck.new,
      PluginPodspecAuthorCheck.new
    ].freeze

    def start(path)
      project = ProjectParser.new(path).project
      if project.nil?
        puts 'No project'
        exit(-1)
      else
        check_project(project)
      end
    end

    def check_project(project)
      result = []
      result += flutter_checks(project)
      result += ios_checks(project)
      result.each { |report| puts report.print }
      exit(result.empty? ? 0 : -1)
    end

    def flutter_checks(project)
      FlutterRb::FLUTTER_CHECKS.map { |check| check.check(project) }.reject do |report|
        report.check_report_status == CheckReportStatus::NORMAL
      end
    end

    def ios_checks(project)
      if project.ios_folder.nil?
        []
      else
        FlutterRb::IOS_CHECKS.map { |check| check.check(project) }.reject do |report|
          report.check_report_status == CheckReportStatus::NORMAL
        end
      end
    end
  end
end
