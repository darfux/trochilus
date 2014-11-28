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
    def apply(ar)
      @active_record = ar
    end
    def get_where_conditions(ar)
      conditions = []
      default_op = :eq
      opts = {}
      ar.each do |wk|
        triple  = (
          if wk.is_a? Hash
            k = wk.keys[0]
            v = @where_keys[k]
            next if (v=@where_keys[k]).nil?
            case wk[k][:type]
            when :time
              v = v.to_time_range
            end
            opts = wk[k]
            op = opts[:op] || :eq
          else
            k = wk
            next if (v=@where_keys[k]).nil?
            op = default_op
          end
          k = @active_record.foreign_keys.invert.fetch(k, k)
          [k, trans_value(v, opts), op]
        )
        conditions << triple
      end
      gen_where_ar_by_triple conditions
    end
    private
      def trans_value(v, opts)
        case v
        when 'true' then true
        when 'false' then false
        else v
        end
        v = v.split if opts[:split]
        v = [v].flatten.collect{ |v| "%#{v}%" } if opts[:op]==:like
        v
      end
      def gen_where_ar_by_triple(triples)
        templates = []
        map = {}
        triples.each do |triple|
          k,v,op = triple
          opstr = (
            case op
            when :eq then '='
            when :like then 'LIKE'
            end
          )
          if v.is_a? Array
            v.each_with_index do |value, i|
              vname = "#{k}_v#{i}"
              template, maplate = gen_template(vname, k, value, opstr)
              templates << template
              map.merge! maplate
            end
          else
            vname = k
            template, maplate = gen_template(vname, k, v, opstr)
            templates << template
            map.merge! maplate
          end
        end
        # binding.pry
        [templates.join(' AND '), map]
      end
      def gen_template(vname, k, value, opstr)
        map = {}
        if value.is_a? Range
          opstr = 'BETWEEN'
          expression = ":#{vname}_s AND :#{vname}_e"
          map.merge!(:"#{vname}_s" => value.begin, :"#{vname}_e" => value.end)
        else
          expression = ":#{vname}"
          map["#{vname}".to_sym] = value
        end
        # binding.pry
        [%Q|#{@active_record.table_name}.#{k} #{opstr} #{expression}|, map]
      end
  end
end