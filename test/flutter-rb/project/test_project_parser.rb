require_relative '../../test__helper.rb'

require 'minitest/autorun'

require_relative '../../../lib/flutter-rb/project/project_parser.rb'

class ProjectParserTest < Minitest::Test
  def test_project_not_exists
    project = FlutterRb::ProjectParser.new('.').project

    assert project.nil?
  end

  def test_project_exists
    path = File.expand_path("#{Dir.pwd}/test_assets/valid_dart_project")
    project = FlutterRb::ProjectParser.new(path).project

    assert !project.nil?

    assert !project.pubspec.nil?
    assert !project.pubspec.pubspec_info.nil?
    assert project.pubspec.pubspec_info.name == 'test_project'

    assert project.android_folder.nil?
    assert project.ios_folder.nil?
  end
end
