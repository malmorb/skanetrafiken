require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['tests/**/*_tests.rb']
  t.verbose = true
end

require 'bundler/gem_helper' 
Bundler::GemHelper.install_tasks