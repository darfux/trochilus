class Trochilus::ModelFilter
  class Sort
    attr_reader :attribute, :desc
    def initialize(h)
      @h = h || {}
      @attribute = (tmp=@h[:attribute]).nil? ? nil : tmp.to_sym
      @desc = (@h[:order]=='1' ? true : false)
    end
    def desc_sql
      desc ? " DESC" : ""
    end
  end
  
  attr_reader :scopes, :sort
  def initialize(params, filter_key=:filters)
    @h = params[filter_key] || {}
    @scopes = @h[:scope] || {}
    @sort = Sort.new(@h[:sort])
  end
  def get_where_conditions(ar)
    conditions = {}
    ar.each do |k|
      next if (v=@scopes[k]).nil?
      conditions[k] = v
    end
    conditions
  end
end