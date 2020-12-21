require_relative '../../test__helper.rb'
require_relative '../../../lib/flutter_rb/project/project.rb'
require_relative '../../../lib/flutter_rb/project/specs/flutter/pubspec.rb'

require 'minitest/autorun'

class PubspecParserTest < Minitest::Test
  def test_parser
    path = File.expand_path("#{Dir.pwd}/test_assets/valid_dart_project/pubspec.yaml")
    pubspec = FlutterRb::PubspecParser.new(YAML.load_file(path)).parse

    assert !pubspec.nil?

    plugin_info = pubspec.pubspec_info
    assert !plugin_info.nil?

    assert plugin_info.name == 'valid_dart_project'
    assert plugin_info.description == 'Valid Dart project'
    assert plugin_info.version == '1.0.0'
    assert plugin_info.author.nil?
    assert plugin_info.homepage == 'https://github.com/fartem/flutter_rb/tree/master/test_assets/valid_dart_project'

    dev_dependencies = pubspec.dev_dependencies
    assert !dev_dependencies.nil?

    assert dev_dependencies.length == 2

    dev_dependency = dev_dependencies.first
    assert dev_dependency.name == 'effective_dart'
    assert dev_dependency.version == '^1.3.0'

    dev_dependency = dev_dependencies.last
    assert dev_dependency.name == 'dart_enum_to_string_check'
    assert dev_dependency.version == '^0.6.2'

    assert pubspec.platform_plugins.nil?
  end
end
