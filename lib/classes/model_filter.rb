# filters
#   scope
#   sort
#     attribute
#     order
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
    ar.each do |scope|
      if scope.is_a? Hash
        k = scope.keys[0]
        v = @scopes[k]
        next if (v=@scopes[k]).nil?
        case scope[k][:type]
        when :time
          from = ((from=v['from']) ? Time.utc(*from.split('-')).yesterday.end_of_day : Time.new(0))
          to = ((to=v['to']) ? Time.utc(*to.split('-')).end_of_day : Time.new(9999))
          v = from..to
        end
      else
        k = scope
        next if (v=@scopes[k]).nil?
        v = (
          case v
          when 'true' then true
          when 'false' then false
          else v
          end
        )
      end
      conditions[k] = v
    end
    conditions
  end
end