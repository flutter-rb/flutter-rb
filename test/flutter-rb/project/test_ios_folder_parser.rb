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
    assert_equal('valid_flutter_project', podspec.name)
    assert_equal('1.0.0', podspec.version)
    assert !podspec.authors.nil?
    assert_equal('.', podspec.source)
  end
end
