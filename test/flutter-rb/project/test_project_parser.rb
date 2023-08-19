require_relative '../../test_helper'
require_relative '../../../lib/flutter_rb/project/project.rb'

require 'minitest/autorun'

class ProjectParserTest < Minitest::Test
  def test_project_not_exists
    project = FlutterRb::ProjectParser.new('.').project

    assert_nil(project)
  end

  def test_project_exists
    path = File.expand_path("./test_assets/valid_dart_project")
    project = FlutterRb::ProjectParser.new(path).project

    assert !project.nil?

    # noinspection RubyNilAnalysis
    assert !project.pubspec.nil?
    assert !project.pubspec.pubspec_info.nil?
    assert_equal(
      'valid_dart_project',
      project.pubspec.pubspec_info.name
    )

    assert_nil(project.android_folder)
    assert_nil(project.ios_folder)
  end
end
