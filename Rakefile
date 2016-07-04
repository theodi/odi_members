require File.join(File.dirname(__FILE__), 'lib/odi_members.rb')

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  require 'coveralls/rake/task'
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'

  RSpec::Core::RakeTask.new
  Coveralls::RakeTask.new

  task :default => [:spec, 'jasmine:ci', 'coveralls:push']
end

task :run do
  sh 'bundle exec compass clean'
  sh 'bundle exec compass watch . &'
  sh 'bundle exec rackup'
end
