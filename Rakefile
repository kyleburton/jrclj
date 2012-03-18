require 'rubygems'
require 'rake'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
load 'jrclj.gemspec'
 
SPEC_FILES = FileList['spec/*_spec.rb']
 
task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new('spec') do |t|
  $:.push "#{File.dirname(__FILE__)}/lib"
  Dir["#{File.dirname(__FILE__)}/deps/*.jar"].each do |jar|
    require jar
  end
  t.pattern = 'spec/*_spec.rb'
end
 
desc "Run rcov"
RSpec::Core::RakeTask.new('rcov') do |t|
  t.pattern = 'spec/*_spec.rb'
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end
 
#Rake::GemPackageTask.new($spec) do |t|
Gem::PackageTask.new($spec) do |t|
  t.need_tar = true
end
