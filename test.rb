$:.unshift "./lib"
require 'rubygems'
require 'jrclj'


clj = JRClj.new
puts "*ns* = #{clj._val "*ns*"}"
clj.eval clj.read_string("(ns user) (def x :value)")
puts "before bindings, x=#{clj._val "user", "x"}"
clj._binding("x" => 3) do |clj|
  puts "in the proc x=#{clj._val "user", "x"}"
  clj._binding("x" => 99) do |clj|
      puts "in the (inner) proc x=#{clj._val "user", "x"}"
  end
end
