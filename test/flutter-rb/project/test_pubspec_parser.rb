require_relative '../../test_helper'
require_relative '../../../lib/flutter_rb/project/project.rb'
require_relative '../../../lib/flutter_rb/project/specs/flutter/pubspec.rb'

require 'minitest/autorun'

class PubspecParserTest < Minitest::Test
  def test_dart_project
    path = File.expand_path("./test_assets/valid_dart_project/pubspec.yaml")
    pubspec = FlutterRb::PubspecParser.new(path, YAML.load_file(path)).parse

    assert !pubspec.nil?

    plugin_info = pubspec.pubspec_info
    assert !plugin_info.nil?

    assert_equal('valid_dart_project', plugin_info.name)
    assert_equal('Valid Dart project', plugin_info.description)
    assert_equal('1.0.0', plugin_info.version)
    assert_nil(plugin_info.author)
    assert(
      'https://github.com/flutter-rb/flutter_rb/tree/master/test_assets/valid_dart_project',
      plugin_info.homepage
    )

    dev_dependencies = pubspec.dev_dependencies
    assert !dev_dependencies.nil?

    assert_equal(2, dev_dependencies.length)

    dev_dependency = dev_dependencies.first
    assert_equal('lints', dev_dependency&.name)
    assert_equal('^2.1.1', dev_dependency&.version)

    dev_dependency = dev_dependencies.last
    assert_equal('dart_enum_to_string_check', dev_dependency&.name)
    assert_equal('^0.6.2', dev_dependency&.version)

    assert_nil(pubspec.platform_plugins)
  end

  def test_flutter_project
    path = File.expand_path("./test_assets/valid_flutter_project/pubspec.yaml")
    pubspec = FlutterRb::PubspecParser.new(path, YAML.load_file(path)).parse

    assert !pubspec.nil?

    plugin_info = pubspec.pubspec_info
    assert !plugin_info.nil?

    assert_equal('valid_flutter_project', plugin_info.name)
    assert_equal('Valid Flutter project', plugin_info.description)
    assert_equal('1.0.0', plugin_info.version)
    assert_nil(plugin_info.author)
    assert(
      'https://github.com/flutter-rb/flutter_rb/tree/master/test_assets/valid_flutter_project',
      plugin_info.homepage
    )

    dev_dependencies = pubspec.dev_dependencies
    assert !dev_dependencies.nil?

    assert_equal(2, dev_dependencies.length)

    dev_dependency = dev_dependencies.first
    assert_equal('flutter_lints', dev_dependency&.name)
    assert_equal('^2.0.2', dev_dependency&.version)

    dev_dependency = dev_dependencies.last
    assert_equal('dart_enum_to_string_check', dev_dependency&.name)
    assert_equal('^0.6.2', dev_dependency&.version)

    assert(!pubspec.platform_plugins.nil?)
  end
end
