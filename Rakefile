require 'rubygems'
require 'rake'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
begin
  load 'jrclj.gemspec'
rescue
  $stderr.puts "WARN: not running in jruby, will not be able to perform some tasks."
end
 
SPEC_FILES = FileList['spec/*_spec.rb']
 
# task :default => :spec
# 
# desc "Run all specs"
# RSpec::Core::RakeTask.new('spec') do |t|
#   $:.push "#{File.dirname(__FILE__)}/lib"
#   Dir["#{File.dirname(__FILE__)}/deps/*.jar"].each do |jar|
#     require jar
#   end
#   t.pattern = 'spec/*_spec.rb'
# end
#  
# desc "Run rcov"
# RSpec::Core::RakeTask.new('rcov') do |t|
#   t.pattern = 'spec/*_spec.rb'
#   t.rcov = true
#   t.rcov_opts = ['--exclude', 'spec']
# end
#  
# #Rake::GemPackageTask.new($spec) do |t|
# Gem::PackageTask.new($spec) do |t|
#   t.need_tar = true
# end

namespace :jruby do
  desc "install jruby"
  task :install do
    url = "http://jruby.org.s3.amazonaws.com/downloads/1.6.7.2/jruby-bin-1.6.7.2.tar.gz"
    unless File.exist? "software"
      FileUtils.mkdir "software"
    end
    Dir.chdir("software") do
      unless File.exist? File.basename(url)
        system "wget", url
      end

      unless File.exist? "jruby-1.6.7.2"
        system "tar", "xzf", File.basename(url)
      end
    end
  end
end
