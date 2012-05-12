require 'rubygems'
require 'java'
Dir["#{File.dirname(__FILE__)}/deps/*.jar"].each do |jar|
  puts "Requiriing: #{jar}"
  require jar
end
require 'jrclj'

clj = JRClj.new
puts "clj.inc: #{clj.inc 99}"
