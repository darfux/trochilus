module ModelFilterActiveRecordExtension

  extend ActiveSupport::Concern

  # add your instance methods here

  # add your static(class) methods here
  module ClassMethods
    class FilterConfig
      cattr_accessor :where_keys, :scoped_orders, :method_orders
      where_keys = scoped_orders = method_orders = []
    end
    [:where_keys, :scoped_orders, :method_orders].each do |name|
      define_method("filter_#{name}") do |ar|
        FilterConfig.send("#{name}=", ar)
      end
    end
    def handle_filter(filters)
      where_keys    = FilterConfig.where_keys
      scoped_orders = FilterConfig.scoped_orders
      method_orders = FilterConfig.method_orders

      scopes  = filters.scopes
      sort    = filters.sort
      where_conditions = filters.get_where_conditions(where_keys)
      relation = current_scope.where(where_conditions)
      desc = sort.desc
      desc_sql = sort.desc_sql

      sa=sort.attribute
      if scoped_orders.include? sa
        if column_names.include? sa.to_s
          relation = relation.reorder("#{sa}#{desc_sql}")
        else
          relation = relation.send(sa, desc)
        end
        # binding.pry
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
