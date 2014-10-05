module PolymorphicExtension
	module ClassMethods
		# def all_instance_of(klass)
		# 	where()
		# end
	end
	
	module InstanceMethods
	end

	def self.included(receiver)
		receiver.class_eval %q{
			def self.set_accessable_attributes(attributes)
				nil
			end
		}
		return unless receiver.table_exists?
		receiver.class_variable_set(:@@accessable_attributes, receiver.column_names)

		#It seems that #class_exec has a bug of context
		receiver.class_eval %q{
			cattr_accessor :accessable_attributes
			def self.set_accessable_attributes(attributes)
				@@accessable_attributes += attributes.collect{|a| a.to_s}
			end
		}
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end