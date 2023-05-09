require_relative '../../test_helper'
require_relative '../../../lib/flutter_rb/project/specs/flutter/pubspec.rb'
require_relative '../../../lib/flutter_rb/project/project.rb'
require_relative '../../../lib/flutter_rb/checks/check.rb'
require_relative '../../../lib/flutter_rb/checks/plugin_pubspec_check.rb'

require 'minitest/autorun'
require 'yaml'

class PluginPubspecCheckStructureTest < Minitest::Test
  def test_pubspec_check_structure
    pubspec_check = FlutterRb::PluginPubspecCheck.new

    assert_raises FlutterRb::Check::UNIMPLEMENTED_ERROR do
      pubspec_check.pubspec_parameter
    end
    assert_raises FlutterRb::Check::UNIMPLEMENTED_ERROR do
      pubspec_check.summary
    end
  end
end

class BasePluginPubspecCheckTest < Minitest::Test
  def load_project(path)
    path = File.expand_path("#{Dir.pwd}/#{path}")
    pubspec = FlutterRb::PubspecParser.new(path, YAML.load_file(path)).parse
    project = FlutterRb::Project.new(path, pubspec, nil, nil)
  end
end

class PluginPubspecNameCheckTest < BasePluginPubspecCheckTest
  def test_on_valid_project
    path = 'test_assets/valid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecNameCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::NORMAL,
      report.check_report_status
    )
  end

  def test_on_invalid_project
    path = 'test_assets/broken_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecNameCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::ERROR,
      report.check_report_status
    )
  end
end

class PluginPubspecAuthorCheckTest < BasePluginPubspecCheckTest
  def test_on_valid_project
    path = 'test_assets/valid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecAuthorCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::NORMAL,
      report.check_report_status
    )
  end

  def test_on_invalid_project
    path = 'test_assets/invalid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecAuthorCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::WARNING,
      report.check_report_status
    )
  end
end

class PluginPubspecDescriptionCheckTest < BasePluginPubspecCheckTest
  def test_on_valid_project
    path = 'test_assets/valid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecDescriptionCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::NORMAL,
      report.check_report_status
    )
  end

  def test_on_invalid_project
    path = 'test_assets/invalid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecDescriptionCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::WARNING,
      report.check_report_status
    )
  end
end

class PluginPubspecVersionCheckTest < BasePluginPubspecCheckTest
  def test_on_valid_project
    path = 'test_assets/valid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecVersionCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::NORMAL,
      report.check_report_status
    )
  end

  def test_on_invalid_project
    path = 'test_assets/invalid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecVersionCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::ERROR,
      report.check_report_status
    )
  end
end

class PluginPubspecHomepageCheckTest < BasePluginPubspecCheckTest
  def test_on_valid_project
    path = 'test_assets/valid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecHomepageCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::NORMAL,
      report.check_report_status
    )
  end

  def test_on_invalid_project
    path = 'test_assets/invalid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecHomepageCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::ERROR,
      report.check_report_status
    )
  end
end

class PluginPubspecEffectiveDartCheckTest < BasePluginPubspecCheckTest
  def test_on_valid_project
    path = 'test_assets/valid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecEffectiveDartCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::NORMAL,
      report.check_report_status
    )
  end

  def test_on_invalid_project
    path = 'test_assets/invalid_dart_project/pubspec.yaml'
    project = load_project(path)

    report = FlutterRb::PluginPubspecEffectiveDartCheck.new.check(project)
    assert_equal(
      FlutterRb::CheckReportStatus::ERROR,
      report.check_report_status
    )
  end
end
