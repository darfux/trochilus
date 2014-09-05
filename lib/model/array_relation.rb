class ArrayRelation < Array
  def where(hash)
    return self unless hash
    # binding.pry
    self.select do |e|
      flag = true
      hash.each_pair do |k,v|
        flag = (
          if v.is_a?(Range)
            v.cover? e.send(k)
            # binding.pry
          else
            e.respond_to?(k) ? e.send(k) == v : true
          end
        )
        break unless flag
      end
      # raise '!' unless flag
      flag
    end
  end
end