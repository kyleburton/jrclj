PKG_VERSION = '1.0.1'
PKG_FILES = Dir['lib/**/*.rb',
                  'spec/**/*.rb']
 
$spec = Gem::Specification.new do |s|
  s.name = 'jrclj'
  s.version = PKG_VERSION
  s.summary = "Bridge Library for working with Clojure from JRuby"
  s.description = <<EOS
Helper library for working with Clojure from JRuby.
EOS
  
  s.files = PKG_FILES.to_a

  s.has_rdoc = false
  s.authors = ["Kyle Burton"]
  s.email = "kyle.burton@gmail.com"
  s.homepage = "http://github.com/kyleburton/jrclj"

end
 
