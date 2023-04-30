require_relative '../../../lib/flutter_rb/project/specs/android/android_folder.rb'

require 'minitest/autorun'

class AndroidFolderParserTest < Minitest::Test
  def test_android_folder_parser
    android_folder_path = "#{Dir.pwd}/test_assets/valid_flutter_project/android"
    android_folder = FlutterRb::AndroidFolder.new(android_folder_path)

    assert !android_folder.nil?

    gradle_config = android_folder.gradle
    assert !gradle_config.nil?
    assert_equal('1.0.0', gradle_config.version)
  end
end

