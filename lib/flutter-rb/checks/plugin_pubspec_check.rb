require_relative 'check'
require_relative '../report/check_report'
require_relative '../report/check_report_status'

require 'yaml'

module FlutterRb
  class PluginPubspecCheck < Check
    def name
      'PluginPubspecCheck'
    end

    def info
      'Validate Flutter plugin pubspec.yaml config'
    end

    def check(plugin_root)
      pubspec = YAML.load_file("#{plugin_root}/pubspec.yaml").inspect
      CheckReport.new(
        name,
        errors?(pubspec) ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        'No provided'
      )
    end

    def errors?(pubspec)
      pubspec['name'].nil? ||
        pubspec['description'].nil? ||
        pubspec['version'].nil? ||
        pubspec['author'].nil? ||
        pubspec['homepage'].nil?
    end
  end
end
