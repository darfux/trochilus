class ArrayRelation < Array
  def where(hash)
    return self unless hash
    self.select do |e|
      flag = true
      hash.each_pair do |k,v|
        flag = (
          if v.is_a?(Range)
            v.cover? e.send(k)
          else
            e.send(k) == v
          end
        )
        break unless flag
      end
      flag
    end
  end
end