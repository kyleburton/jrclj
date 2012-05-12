require 'rubygems'
require 'java'
Dir["#{File.dirname(__FILE__)}/deps/*.jar"].each do |jar|
  require jar
end
require 'jrclj'

clj = JRClj.new
clj._import "clojure.test"
clj._eval "(create-ns 'my.test)"
clj._eval <<END
(binding [*ns* (create-ns 'my.test)]
  (eval '(ns my.test))
  (eval '(defn a-function [] (println "in a-function"))))
END

clj._eval "(my.test/a-function)"
