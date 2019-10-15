require 'bundler/gem_tasks'
require 'rake/testtask'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
rescue LoadError
end

task :console do
  require 'irb'
  require 'irb/completion'
  require 'howlong'
  ARGV.clear
  IRB.start
end
