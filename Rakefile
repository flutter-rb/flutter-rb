require 'rake/clean'

task default: %i[clean rubocop]

desc 'Run Rubocop'
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end
