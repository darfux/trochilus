# encoding: utf-8

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


class ChTranser
  @@table = AliasedHash.new
  @@table.merge!({
    :IndividualCustomer => '个人客户'
  })
  def self.trans(word)
    @@table[word.to_sym]
  end
end