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

  # desc "donwload dependencies for examples"
  # task :deps do
  #   Dir.chdir "deps" do
  #     # http://repo1.maven.org/maven2/org/clojure/clojure/1.4.0/clojure-1.4.0.zip
  #     %w[http://repo1.maven.org/maven2/org/clojure/clojure/1.3.0/clojure-1.3.0.zip].each do |url|
  #       unless File.exist? File.basename(url)
  #         system "wget", url
  #       end
  #     end
  #   end
  # end

  desc "run JRuby irb"
  task :irb do |t,args|
    system "./software/jruby-1.6.7.2/bin/jruby", "-I", "lib", "./software/jruby-1.6.7.2/bin/jirb"
  end

  desc "run a JRuby script"
  task :run, :script do |t,args|
    system "./software/jruby-1.6.7.2/bin/jruby", "-I", "lib", args[:script]
  end
end
