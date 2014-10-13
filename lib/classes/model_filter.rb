class Trochilus::ModelFilter
  class Sort
    def initialize(h)
      @h = h || {}
    end
    def desc
      @desc ||= (@h[:order]=='1' ? true : false)
    end
    def desc_sql
      desc ? " DESC" : ""
    end
    def attribute
      @h[:attribute]
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