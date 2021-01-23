require_relative '../../test__helper.rb'
require_relative '../../../lib/flutter_rb/project/project.rb'
require_relative '../../../lib/flutter_rb/project/specs/ios/ios_folder.rb'

require 'minitest/autorun'

class IOSFolderParserTest < Minitest::Test
  def test_ios_folder_parser
    project_path = "#{Dir.pwd}/test_assets/valid_flutter_project"
    project = FlutterRb::ProjectParser.new(project_path).project.pubspec

    ios_folder = FlutterRb::IOSFolder.new("#{project_path}/ios", project)

    assert !ios_folder.nil?

    podspec = ios_folder.podspec
    assert !podspec.nil?
    assert podspec.name == 'valid_flutter_project'
    assert podspec.version == '1.0.0'
    assert !podspec.authors.nil?
    assert podspec.source == '.'
  end
end
