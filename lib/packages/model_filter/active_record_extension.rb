module ModelFilter
  module ActiveRecordExtension
    module Inner
      FUNCS = [:where_keys, :scoped_orders, :method_orders, :scopes, :virtual_columns]
      class FilterConfig
        attr_accessor *FUNCS
        def initialize
          FUNCS.each do |f|
            instance_variable_set("@#{f}", [])
          end
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
          FUNCS.each do |name|
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
          scopes        = _filter_config.scopes
          where_keys    = _filter_config.where_keys
          scoped_orders = _filter_config.scoped_orders
          method_orders = _filter_config.method_orders
          virtual_columns = _filter_config.virtual_columns

          sort    = filters.sort
          where_conditions = filters.get_where_conditions(where_keys)
          relation = (current_scope||all).where(where_conditions)
          desc = sort.desc
          desc_sql = sort.desc_sql

          scopes  = filters.get_scopes(scopes)
          scopes.each do |scope|
            relation = relation.send(scope.name, *scope.params)
          end
          
          sa=sort.attribute
          if scoped_orders.include? sa
            if column_names.include? sa.to_s or virtual_columns.include? sa.to_sym
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
