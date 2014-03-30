class FalseClass
  def ch
    '否'
  end
end

class TrueClass
  def ch
    '是'
  end
end

# http://stackoverflow.com/questions/15913950/ruby-hash-with-multiple-keys-pointing-to-the-same-value?answertab=votes#answer-15914313
class AliasedHash < Hash
  def initialize(*args)
    super
    @aliases = {}
  end

  def alias(from,to)
    @aliases[from] = to
    self
  end

  def [](key)
    super(alias_of(key))
  end

  def []=(key,value)
    super(alias_of(key), value)
  end

  private
  def alias_of(key)
    @aliases.fetch(key,key)
  end
end