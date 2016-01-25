require 'rake'
require 'rubygems/package_task'
require 'rdoc/task'
require 'yaml'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

gemspec = eval(IO.read('mixlib-log.gemspec'))

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

# For rubygems-test
task :test => :spec

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mixlib-log #{Mixlib::Log::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end

