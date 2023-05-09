require_relative '../../test_helper'
require_relative '../../../lib/flutter_rb/checks/plugin_directories_check.rb'
require_relative '../../../lib/flutter_rb/checks/plugin_gradle_check.rb'
require_relative '../../../lib/flutter_rb/checks/plugin_podspec_check.rb'
require_relative '../../../lib/flutter_rb/checks/plugin_pubspec_check.rb'

require 'minitest/autorun'
require 'yaml'

class CheckDescriptionTest < Minitest::Test
  def test_check_description
    default_description = 'No provided'

    plugin_directories_check = FlutterRb::PluginDirectoriesCheck.new
    assert plugin_directories_check.description != default_description

    plugin_gradle_version_check = FlutterRb::PluginGradleVersionCheck.new
    assert plugin_gradle_version_check.description != default_description

    plugin_gradle_android_package_check = FlutterRb::PluginGradleAndroidPackageCheck.new
    assert plugin_gradle_android_package_check.description != default_description

    plugin_podspec_name_check = FlutterRb::PluginPodspecNameCheck.new
    assert plugin_podspec_name_check.description != default_description

    plugin_podspec_version_check = FlutterRb::PluginPodspecVersionCheck.new
    assert plugin_podspec_version_check.description != default_description

    plugin_podspec_author_check = FlutterRb::PluginPubspecAuthorCheck.new
    assert plugin_podspec_author_check.description != default_description

    plugin_podspec_source_check = FlutterRb::PluginPodspecSourceCheck.new
    assert plugin_podspec_source_check.description != default_description

    plugin_pubspec_name_check = FlutterRb::PluginPubspecNameCheck.new
    assert plugin_pubspec_name_check.description != default_description

    plugin_pubspec_description_check = FlutterRb::PluginPubspecDescriptionCheck.new
    assert plugin_pubspec_description_check.description != default_description

    plugin_pubspec_version_check = FlutterRb::PluginPubspecVersionCheck.new
    assert plugin_pubspec_version_check.description != default_description

    plugin_pubspec_author_check = FlutterRb::PluginPubspecAuthorCheck.new
    assert plugin_pubspec_author_check.description != default_description

    plugin_pubspec_homepage_check = FlutterRb::PluginPubspecHomepageCheck.new
    assert plugin_pubspec_homepage_check.description != default_description

    plugin_pubspec_effective_dart_check = FlutterRb::PluginPubspecEffectiveDartCheck.new
    assert plugin_pubspec_effective_dart_check.description != default_description
  end
end
