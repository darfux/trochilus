class Hash
  def direct_fetch(chain, default=nil)
    tmp = self
    last_key = chain.pop
    chain.each do |key|
      if (v=tmp[key]) && v.is_a?(Hash)
        tmp = v
      else
        tmp = nil
        break
      end
    end
    (tmp && tmp[last_key]) || default
  end
  def to_time_range
    tmp = {}
    self.each_pair do |k, v|
      k = k.to_sym
      tmp[k] = v if k == :from or k == :to 
    end
    unless tmp.empty?
      from = ((from=tmp[:from]) ? Time.utc(*from.split('-')).yesterday.end_of_day : Time.new(0))
      to = ((to=tmp[:to]) ? Time.utc(*to.split('-')).end_of_day : Time.new(9999))
      from..to
    else
      nil
    end
  end
end