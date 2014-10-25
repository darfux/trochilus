module ActionView
  module Helpers
    class FormBuilder
      alias_method :org_date_select, :date_select
      def date_select(method, options = {}, html_options = {})
        hclass = html_options[:class]
        hclass = hclass ? hclass+' date-select' : 'date-select'
        org_date_select(method, options, html_options.merge(class: hclass))
      end
    end
  end
end
