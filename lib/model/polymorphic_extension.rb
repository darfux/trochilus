module PolymorphicExtension
	def self.included(receiver)
		receiver.class_variable_set(:@@accessable_attributes, receiver.column_names)

		#It seems that #class_exec has a bug of context
		receiver.class_eval %q{
			cattr_accessor :accessable_attributes
			def self.set_accessable_attributes(attributes)
				@@accessable_attributes += attributes
			end
		}
	end
end