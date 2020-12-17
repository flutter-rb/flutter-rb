require_relative '../../test__helper.rb'
require_relative '../../../lib/flutter-rb/project/specs/flutter/pubspec.rb'
require_relative '../../../lib/flutter-rb/project/project.rb'
require_relative '../../../lib/flutter-rb/checks/plugin_pubspec_check.rb'

require 'minitest/autorun'
require 'yaml'

class PluginPubspecCheckTest < Minitest::Test
  def test_valid_pubspec_author_declaration
    path = File.expand_path("#{Dir.pwd}/test_assets/valid_dart_project/pubspec.yaml")
    pubspec = FlutterRb::PubspecParser.new(YAML.load_file(path)).parse
    project = FlutterRb::Project.new(pubspec, nil, nil)

    report = FlutterRb::PluginPubspecAuthorCheck.new.check(project)
    assert report.check_report_status == FlutterRb::CheckReportStatus::NORMAL
  end

  def test_invalid_pubspec_author_declaration
    path = File.expand_path("#{Dir.pwd}/test_assets/invalid_dart_project/pubspec.yaml")
    pubspec = FlutterRb::PubspecParser.new(YAML.load_file(path)).parse
    project = FlutterRb::Project.new(pubspec, nil, nil)

    report = FlutterRb::PluginPubspecAuthorCheck.new.check(project)
    assert report.check_report_status == FlutterRb::CheckReportStatus::WARNING
  end
end
