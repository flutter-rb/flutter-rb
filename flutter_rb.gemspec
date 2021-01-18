require 'English'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.7.0'
  s.name = 'flutter_rb'
  s.version = '0.6.2'
  s.license = 'MIT'
  s.files = Dir['lib/**/*.rb'] + %w[bin/frb README.md LICENSE]
  s.executable = 'frb'
  s.require_paths << 'lib'
  s.summary = 'A Ruby tool for checking a Flutter plugin structure'
  s.authors = ['Artem Fomchenkov']
  s.email = 'jaman.smlnsk@gmail.com'
  s.homepage = 'http://github.com/fartem/flutter-rb'
  s.test_files = s.files.grep(%r{^(test)/})
  s.extra_rdoc_files = ['README.md']

  s.add_runtime_dependency 'cocoapods', '1.10.0'
  s.add_runtime_dependency 'colorize', '0.8.1'
  s.add_runtime_dependency 'nokogiri', '1.11.0'

  s.add_development_dependency 'coveralls', '0.8.23'
  s.add_development_dependency 'minitest', '5.14.0'
  s.add_development_dependency 'rake', '12.3.3'
  s.add_development_dependency 'rubocop', '1.7'
  s.add_development_dependency 'simplecov', '0.16.1'
end
