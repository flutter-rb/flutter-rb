require 'minitest/autorun'

require_relative '../../../lib/flutter-rb/project/project_parser.rb'
require_relative '../../../lib/flutter-rb/project/specs/flutter/pubspec.rb'

class PubspecParserTest < Minitest::Test
  def test_parser
    path = File.expand_path("#{Dir.pwd}/test_assets/valid_dart_project/pubspec.yaml")
    pubspec = FlutterRb::PubspecParser.new(YAML.load_file(path)).parse

    assert !pubspec.nil?

    plugin_info = pubspec.pubspec_info
    assert !plugin_info.nil?

    assert plugin_info.name == 'test_project'
    assert plugin_info.description == 'Test project'
    assert plugin_info.version == '1.0.0'
    assert plugin_info.author.nil?
    assert plugin_info.homepage == 'https://github.com/fartem/flutter-rb/tree/master/test_assets/valid_dart_project'

    dev_dependencies = pubspec.dev_dependencies
    assert !dev_dependencies.nil?

    assert dev_dependencies.length == 1

    dev_dependency = dev_dependencies.first
    assert dev_dependency.name == 'dart_enum_to_string_check'
    assert dev_dependency.version == '^0.6.2'

    assert pubspec.platform_plugins.nil?
  end
end
