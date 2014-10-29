module SimpleReflectorExtension
  extend ActiveSupport::Concern
  
  module ClassMethods
    def simple_reflect(name)
      r = reflections[name.to_sym]
      SimpleReflector.new(r)
    end
  end
end