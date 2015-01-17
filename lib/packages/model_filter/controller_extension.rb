module ModelFilter
  module ControllerExtension
    module Inner
      extend ActiveSupport::Concern

      def current_filter
        ModelFilter::Filter.new(params)
      end
      module ClassMethods
      end
    end
    include InnerForAllSubclass
  end
end