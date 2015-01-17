module SimpleReflector
  module ActiveRecordExtension
    module Inner
      extend ActiveSupport::Concern
      
      module ClassMethods
        def simple_reflect(name)
          r = reflections[name.to_sym]
          SimpleReflector::Reflector.new(r)
        end
      end
    end
    include InnerForAllSubclass
  end
end