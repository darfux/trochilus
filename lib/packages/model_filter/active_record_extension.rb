module ModelFilter
  module ActiveRecordExtension
    module Inner

      class FilterConfig
        attr_accessor :where_keys, :scoped_orders, :method_orders
        def initialize
          @where_keys = @scoped_orders = @method_orders = []
        end
      end

      extend ActiveSupport::Concern

      included do
        if self.respond_to? :_filter_config
          raise "_filter_config conflict!"
        end
        cattr_accessor :_filter_config
        self._filter_config = FilterConfig.new
        class << self
          [:where_keys, :scoped_orders, :method_orders].each do |name|
            define_method("filter_#{name}") do |ar|
              _filter_config.send("#{name}=", ar)
            end
          end
        end
      end
      # add your instance methods here

      # add your static(class) methods here
      module ClassMethods
        # def get_config
        #   FilterConfig
        # end
        def handle_filter(filters)
          where_keys    = _filter_config.where_keys
          scoped_orders = _filter_config.scoped_orders
          method_orders = _filter_config.method_orders

          sort    = filters.sort
          where_conditions = filters.get_where_conditions(where_keys)
          relation = (current_scope||all).where(where_conditions)
          desc = sort.desc
          desc_sql = sort.desc_sql

          scopes  = filters.scopes
          scopes.each do |scope|
            relation.send(scope.name, *scope.param)
          end

          sa=sort.attribute
          if scoped_orders.include? sa
            if column_names.include? sa.to_s
              relation = relation.reorder("#{sa}#{desc_sql}")
            else
              relation = relation.send(sa, desc)
            end
          end
          if method_orders.include? sa
            tmp = relation.sort_by{|p| p.send(sa)}
            tmp.reverse! if desc
            relation = tmp
          end
          relation.to_a
        end
      end
    end
    include InnerForAllSubclass
  end
end
