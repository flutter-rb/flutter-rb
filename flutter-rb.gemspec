require 'English'

Gem::Specification.new do |s|
  s.required_ruby_version = '2.7.0'
  s.name = 'flutter-rb'
  s.version = '0.4.2'
  s.license = 'MIT'
  s.summary = 'A Ruby tool for checking a Flutter plugin structure'
  s.authors = ['Artem Fomchenkov']
  s.email = 'jaman.smlnsk@gmail.com'
  s.homepage = 'http://github.com/fartem/flutter-rb'
  s.test_files = s.files.grep(%r{^(test)/})
  s.extra_rdoc_files = ['README.md']
  s.add_development_dependency 'cocoapods', '1.10.0'
  s.add_development_dependency 'colorize', '0.8.1'
  s.add_development_dependency 'rake', '12.3.3'
  s.add_development_dependency 'rubocop', '1.4.2'
end
