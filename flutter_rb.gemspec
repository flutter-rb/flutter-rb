# frozen_string_literal: true

require 'English'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 3.0'
  s.name = 'flutter_rb'
  s.version = '1.2.3'
  s.license = 'MIT'
  s.files = Dir['lib/**/*.rb'] + %w[bin/frb bin/cli.rb README.md LICENSE]
  s.executable = 'frb'
  s.require_paths << 'lib'
  s.summary = 'CLI tool for checking a Flutter plugin structure'
  s.authors = ['Artem Fomchenkov']
  s.email = 'artem.fomchenkov@outlook.com'
  s.homepage = 'https://github.com/flutter-rb/flutter-rb'
  s.test_files = s.files.grep(%r{^(test)/})
  s.extra_rdoc_files = ['README.md']

  s.add_runtime_dependency 'cocoapods', '1.10.0'
  s.add_runtime_dependency 'colorize', '0.8.1'
  s.add_runtime_dependency 'dry-cli', '1.0.0'
  s.add_runtime_dependency 'nokogiri', '1.13.9'

  s.add_development_dependency 'minitest', '5.14.0'
  s.add_development_dependency 'rake', '12.3.3'
  s.add_development_dependency 'rdoc', '6.6.2'
  s.add_development_dependency 'rubocop', '1.7'
  s.add_development_dependency 'simplecov', '0.22.0'
end
