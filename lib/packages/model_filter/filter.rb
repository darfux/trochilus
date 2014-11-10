# filters
#   scope
#   where
#   sort
#     attribute
#     order

module ModelFilter
  class Filter
    KEY = OpenStruct.new.tap do |o|
      o.scope = :sc
      o.where = :wk
      o.sort  = :st
    end
    class Sort
      attr_reader :attribute, :desc
      def initialize(h)
        @h = h || {}
        @attribute = (tmp=@h[:attr]).nil? ? nil : tmp.to_sym
        @desc = (@h[:order]=='1' ? true : false)
      end
      def desc_sql
        desc ? " DESC" : ""
      end
    end
    class Scope
      attr_accessor :name, :params
      def initialize(n, p)
        @name = n
        @params = p
      end
    end
    attr_reader :scopes, :sort, :where_keys
    def initialize(params, filter_key=:filters)
      @h = params[filter_key] || {}
      @scopes = @h[KEY.scope] || {}
      @where_keys = @h[KEY.where] || {}
      @sort = Sort.new(@h[KEY.sort])
    end
    def get_scopes(ar)
      scopes = []
      ar.each do |sc|
        if v=@scopes[sc]
          scopes << Scope.new(sc, v)
        end
      end
      scopes
    end
    def get_where_conditions(ar)
      conditions = {}
      ar.each do |wk|
        if wk.is_a? Hash
          k = wk.keys[0]
          v = @where_keys[k]
          next if (v=@where_keys[k]).nil?
          case wk[k][:type]
          when :time
            v = v.to_time_range
          end
        else
          k = wk
          next if (v=@where_keys[k]).nil?
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
end