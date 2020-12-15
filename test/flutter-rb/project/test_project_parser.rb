require 'minitest/autorun'

require_relative '../../../lib/flutter-rb/project/project_parser.rb'

class ProjectParserTest < Minitest::Test
  def test_project_not_exists
    project = FlutterRb::ProjectParser.new('.').project

    assert project.nil?
  end
end
