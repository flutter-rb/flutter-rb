require 'English'

Gem::Specification.new do |s|
  s.required_ruby_version = '2.7.0'

  s.name = 'flutter-rb'
  s.version = '1.0.0'

  s.license = 'Apache 2.0'
  s.summary = 'A Ruby tool for checking Flutter plugins structure'
  s.authors = ['Artem Fomchenkov']
  s.email = 'jaman.smlnsk@gmail.com'
  s.homepage = 'http://github.com/fartem/flutter-rb'

  s.test_files = s.files.grep(%r{^(test)/})

  s.extra_rdoc_files = ['README.md']
  s.add_development_dependency 'rake', '12.3.3'
  s.add_development_dependency 'rubocop', '1.4.2'
end
