module InnerForAllSubclass
  def self.included(reciever)
    reciever::Inner
    reciever.class_eval do
      def self.included(r_reciever)
        org_method_name = "inherited_org_by_#{self.to_s.underscore}"
        r_reciever.class_eval(%Q{\
          class << self
            alias_method :#{org_method_name}, :inherited unless method_defined? :#{org_method_name}
            def inherited(subclass)
              #{org_method_name}(subclass)
              subclass.send(:include, #{self}::Inner)
            end
          end\
        })
      end
    end
  end
end