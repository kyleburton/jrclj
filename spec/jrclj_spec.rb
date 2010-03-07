require 'java'
$:.push "#{File.dirname(__FILE__)}/../lib"
require 'jrclj'

describe JRClj do
  it "should support core functions" do
    core = JRClj.new
    core.+(3, 2).should == 5
    core./(3, 2).should == 1.5
    core.inc(2).should == 3
  end

  it "should support loading other libraries (contrib)" do
    str_utils = JRClj.new 'clojure.contrib.str-utils'
    str_utils.str_join(":", [1,2,3]).should == "1:2:3"
  end

  it "should support calling weirdly named symbols via aliasing" do
    clj_xpath = JRClj.new 'com.github.kyleburton.clj-xpath'
    clj_xpath._alias "x_txt", "$x:text"
    clj_xpath._invoke("$x:text", "//foo", "<foo>bar</foo>").should == "bar"
    clj_xpath.x_txt("//foo", "<foo>bar</foo>").should == "bar"
  end
end
