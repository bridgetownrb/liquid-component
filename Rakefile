require "bundler/gem_tasks"

#$LOAD_PATH.unshift File.expand_path("lib", __dir__)
#require "bridgetown-core/version"

task :spec => :test
task default: :test

require "rake/testtask"
Rake::TestTask.new(:test) do |test|
  test.libs << "lib" << "test"
  test.pattern = "test/**/test_*.rb"
  test.verbose = true
end
