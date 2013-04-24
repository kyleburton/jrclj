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

$jruby_version = "1.7.3"

namespace :jruby do
  desc "install jruby"
  task :install do
    url = "http://jruby.org.s3.amazonaws.com/downloads/#{$jruby_version}/jruby-bin-#{$jruby_version}.tar.gz" # "http://jruby.org.s3.amazonaws.com/downloads/1.6.7.2/jruby-bin-1.6.7.2.tar.gz"
    fname = File.basename(url)
    unless File.exist? "software"
      FileUtils.mkdir "software"
    end
    Dir.chdir("software") do
      unless File.exist? File.basename(url)
        unless system "wget", url 
          raise "Error executing wget #{url} : #$!"
        end
      end

      unless File.exist? File.basename(fname, ".tar.gz")
        unless system "tar", "xzf", fname
          raise "Error extracting tar: #$!"
        end
      end
    end
  end

  desc "run JRuby irb"
  task :irb do |t,args|
    cmd =  "./software/jruby-#{$jruby_version}/bin/jruby -I lib ./software/jruby-#{$jruby_version}/bin/jirb"
    unless system cmd
      raise "Error executing jirb: #$! [#{cmd}]"
    end
  end

  desc "run a JRuby script"
  task :run, :script do |t,args|
    cmd = "./software/jruby-#{$jruby_version}/bin/jruby -I lib #{args[:script]}"
    unless system cmd
      raise "Error executing jruby: #$! [#{cmd}]"
    end
  end
end
