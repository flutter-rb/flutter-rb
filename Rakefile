require 'rake/clean'

task default: %i[clean rubocop]

desc 'Run Rubocop'
require 'rubocop/rake-task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.failOnError = true
end
