module JoinArgable
  PackageManager.use('SimpleReflector')
  extend ActiveSupport::Concern
  module ClassMethods
    def join_arg(name, selfas, conditions = {}, type=:inner)
      klass, tn, target_alias = (
        case name
        when Symbol
          reflections[name].klass
        when String
          reflections[name.to_sym].klass
        when Hash
          k = name.first[0]
          [reflections[k].klass, k, name[k][:as]]
        end
      )
      target_reflector, self_alias = (
        case selfas
        when Symbol, String
          klass.simple_reflect(selfas)
        when Hash
          k = selfas.first[0]
          [klass.simple_reflect(k), selfas[k][:as]]
        end
      )
      opts = {type: type}

      if tn && self.simple_reflect(tn).polymorphic
        name = {selfas => self}
      end

      if selfas.is_a? Hash
        opts[:as] = selfas.first[1][:as]
      end

      new_con = {}
      if conditions
        conditions.each_pair do |table, values|
          new_con[table] = []
          values.each_pair do |col, v|
            new_con[table] << [col, v]
          end
        end
      end
      ja(name, new_con, opts)
    end

    #name
    # => string or {poly_name: klass} or {name: {opts}}
    # => ja(:target, nil, {as: :kk})
    # Project.ja({project_type: {as: :pt}}, {pt: [:id, 1]}, {as: :pj})
    def ja(name, conditions=nil, opts={})
      opts = {type: :inner}.merge opts
      poly = false
      target_as = nil
      conditions ||= {}
      klass, table = (
        case name
        when Hash
          k, v = name.first
          if v.is_a? Hash
            target_as = v[:as]
            if poly=v[:poly]
              [poly, find_relation(poly, k).name]
            else
              [self, k]
            end
          else
            [v, find_relation(v, k).name]
          end
        when Symbol
          [self, name]
        end
      )
      node = ActiveRecord::Associations::JoinDependency.new(klass, table, []).join_constraints([]).first
      node = Marshal.load(Marshal.dump(node))

      case opts[:type]
      when :inner
      when :outer
        node = Arel::Nodes::OuterJoin.new(node.left, node.right)
      else
        raise 'wrong join type'
      end

      if klass != self
        t = find_table(node, klass) || Arel::Table.new(klass.table_name)
        node.left = t
      end

      if target_as
        tmp = node.left
        node.left = node.left.dup
        tmp.name = target_as
        node.left = node.left.alias(target_as)
      end

      if selfas=opts[:as]
        t = find_table(node, self)
        t.name = selfas
      end

      builds = build_condition(conditions)
      unless builds.empty?
        e = node.right.expr
        node.right.expr = e.and(builds)
      end
      node
    end

    def oja(name, conditions=nil, opts={})
      ja(name, conditions, opts.merge(type: :outer))
    end
    def outerjoin_arg(name, selfas, conditions = {})
      join_arg(name, selfas, conditions, :outer)
    end

    protected
      def find_relation(klass, role)
        rs = klass.reflections
        # r = rs[self.table_name.to_sym] || rs[self.table_name.singularize.to_sym]
        # return r if r
        for k,r in rs
          break if r.options[:as] == role && r.klass == self
        end
        r
      end

      # {table: [col, value]}
      # {table: [col, {target: :col}]}
      # {table: [col, {target: :col}, op]}
      # {table: [
      #   [col, {target: :col}, op], [...], ...
      # ]
      def build_condition(conditions)
        builds = []
        conditions.each_pair do |table, tcs|
          tcs = (tcs.flatten == tcs ? [tcs] : tcs)
          tcs.each do |tc|
            attribute = tc[0]

            case tc.size
            when 2 then value, op = tc[1], :auto
            when 3 then value, op = tc[1..2]
            end

            eql = Arel::Table.new(table)[attribute.to_sym]

            eqr = (
              case value
              when Hash then Arel::Attributes::Attribute.new.tap { |a| a.relation, a.name = value.first } 
              else value
              end
            )

            builds << (
              case op
              when :auto
                case eqr
                when Range then eql.in eqr
                else eql.eq eqr
                end
              end
            )
          end
        end
        builds
      end

      def walk_through(node, &block)
        return nil unless node
        if node.is_a? Array
          res = nil
          node.each do |n|
            break if res=(walk_through(n, &block))
          end
          return res if res
        end
        res = yield(node) || 
        walk_through(node.try(:expr), &block) || 
        walk_through(node.try(:left), &block) || 
        walk_through(node.try(:right), &block)
        res
      end

      def find_table(node, klass)
        walk_through(node) do |n| 
          if (t=(n.try(:relation) || n )).is_a?(Arel::Table) && t.engine==klass
            t
          else
            nil
          end
        end
      end
  end
end