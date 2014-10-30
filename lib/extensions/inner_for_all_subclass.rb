module InnerForAllSubclass
  def self.included(reciever)
    reciever::Inner
    reciever.class_eval do
      def self.included(r_reciever)
        org_method_name = "inherited_org_by_#{self.to_s.underscore.gsub('/', '__')}"
        r_reciever.class_eval(%Q{\
          class << self
            unless method_defined?(:#{org_method_name})
              if method_defined? :inherited
                alias_method :#{org_method_name}, :inherited
              else
                def #{org_method_name}(subclass)
                end
              end
              def inherited(subclass)
                #{org_method_name}(subclass)
                subclass.send(:include, #{self}::Inner)
              end
            end
          end\
        })
      end
    end
  end
end