test -d build || mkdir build
cd build
test -f jruby-bin-1.6.7.tar.gz || wget http://jruby.org.s3.amazonaws.com/downloads/1.6.7/jruby-bin-1.6.7.tar.gz

test -d jruby-1.6.7 || tar xzvf jruby-bin-1.6.7.tar.gz
