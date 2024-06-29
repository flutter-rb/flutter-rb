require_relative '../../test_helper'
require_relative '../../../lib/flutter_rb/checks/plugin_directories_check.rb'
require_relative '../../../lib/flutter_rb/checks/plugin_gradle_check.rb'
require_relative '../../../lib/flutter_rb/checks/plugin_podspec_check.rb'
require_relative '../../../lib/flutter_rb/checks/plugin_pubspec_check.rb'

require 'minitest/autorun'
require 'yaml'

# noinspection RubyLocalVariableNamingConvention
class CheckDescriptionTest < Minitest::Test
  def test_check_description
    [
      FlutterRb::PluginDirectoriesCheck.new,
      FlutterRb::PluginGradleVersionCheck.new,
      FlutterRb::PluginGradleAndroidPackageCheck.new,
      FlutterRb::PluginPubspecLintsCheck.new,
      FlutterRb::PluginPubspecFlutterLintsCheck.new,
    ].each { |check| assert !check.description.nil? }

    [
      FlutterRb::PluginPodspecNameCheck.new,
      FlutterRb::PluginPodspecVersionCheck.new,
      FlutterRb::PluginPodspecAuthorsCheck.new,
      FlutterRb::PluginPodspecSourceCheck.new,
    ].each do |check|
      assert_equal(
        check.description,
        "Validate Flutter plugin's #{check.podspec_parameter} in podspec file"
      )
    end

    [
      FlutterRb::PluginPubspecNameCheck.new,
      FlutterRb::PluginPubspecDescriptionCheck.new,
      FlutterRb::PluginPubspecVersionCheck.new,
      FlutterRb::PluginPubspecAuthorCheck.new,
      FlutterRb::PluginPubspecHomepageCheck.new,
    ].each do |check|
      assert_equal(
        check.description,
        "Validate Flutter plugin's #{check.pubspec_parameter} in pubspec.yaml"
      )
    end

    plugin_podspec_check = FlutterRb::PluginPodspecCheck.new
    assert_raises FlutterRb::Check::UNIMPLEMENTED_ERROR do
      plugin_podspec_check.description
    end

    plugin_pubspec_check = FlutterRb::PluginPubspecCheck.new
    assert_raises FlutterRb::Check::UNIMPLEMENTED_ERROR do
      plugin_pubspec_check.description
    end
  end
end
