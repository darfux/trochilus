module ModelFilter
  module ViewHelpers
    def filter_type
      ModelFilter::Filter::KEY
    end
    def filter_tag(klass, attribute, type)
      content_tag('span', :class => :filter, 'filter-type'=>type) do
        select_tag(attribute, 
          options_from_collection_for_select(
            select_existed(klass, attribute), 
              :id, :name, default_filter_val(attribute, type)
          ), prompt: "全部"
        )
      end
    end

    def select_existed(host_klass, dest)
      host_table = host_klass.table_name
      dest_klass = 
        (klass = host_klass.reflect_on_association(dest).options[:class_name]).nil? ? dest.to_s.classify.constantize : klass.to_s.constantize
      dest_table = dest_klass.table_name
      host_klass.group("#{dest}_id")
        .joins(dest)
        .select("'#{dest_table}'.'name', '#{dest_table}'.'id'")
    end
    
    def default_filter_val(filter, type)
      (f = params.direct_fetch([:filters, type.to_sym])).nil? ? nil : f[filter]
    end
  end
end