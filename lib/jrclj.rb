require 'java'

#Dir["#{File.dirname(__FILE__)}/*.jar"].each { |jar| puts "requiring: #{jar}"; require jar }
import "clojure.lang.RT"
import "clojure.lang.Var"

class JRClj
  def initialize *pkgs
    @mappings = {}
    @ns_map  = RT.var "clojure.core", "ns-map"
    @symbol  = RT.var "clojure.core", "symbol"
    @require = RT.var "clojure.core", "require"
    _import "clojure.core"
    pkgs.each do |pkg|
      _import pkg
    end
  end

  def _import pkg_name, sym=nil, sym_alais=nil
    @require.invoke @symbol.invoke(pkg_name)
    if sym
      sym_alias ||= sym
      @mappings[sym_alias] = RT.var pkg_name, sym
      return
    end
    pkg = @symbol.invoke pkg_name
    @ns_map.invoke(pkg).each do |sym,var|
      @mappings[sym.to_s] = var
    end
  end

  def _invoke m, *args
    fun = @mappings[m.to_s] || @mappings[m.to_s.gsub "_", "-"]
    unless fun
      raise "Error, no current binding for symbol=#{m}"
    end
    fun.invoke(*args)
  end

  def _alias new, old
    @mappings[new] = @mappings[old]
  end

  def method_missing symbol, *args
    _invoke symbol, *args
  end

  def self.persistent_map entries=[]
    Java::ClojureLang::PersistentArrayMap.new entries.to_java
  end

  def _val ns, var=nil
    unless var
      var = ns
      ns = "clojure.core"
    end
    # (var-get (clojure.lang.RT/var (str *ns*), "x"))
    # puts "Looking up #{ns} / #{var}"
    self.var_get RT.var(ns,var)
  end

  def _binding vars={}
    # the macro expansion of (binding [x 3] x) is:
    # (do
    #   (. clojure.lang.Var (clojure.core/pushThreadBindings (clojure.core/hash-map (var x) 3)))
    #   (try
    #    x
    #    (finally (. clojure.lang.Var (clojure.core/popThreadBindings)))))

    kv_pairs = []
    vars.each do |k,v|
      kv_pairs << RT.var("user",k)
      kv_pairs << v
    end
    # $stderr.puts "kv_pairs (#{kv_pairs.inspect})"
    hm = self.apply RT.var('clojure.core','hash-map'), kv_pairs
    # $stderr.puts "pushing thread bindings (#{hm})"
    Var.pushThreadBindings hm
    pushed = true
    # $stderr.puts "pushed thread bindings (#{hm})"
    yield self
  ensure
    # $stder.puts "in the ensure block"
    Var.popThreadBindings if pushed
  end
end

