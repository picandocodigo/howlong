require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new("test") do |t|
  t.pattern = "test/**/*_test.rb"
end

task :console do
  require 'irb'
  require 'irb/completion'
  require 'howlong'
  ARGV.clear
  IRB.start
end

task :default => 'test'
