require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end


if ENV['CI']
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
