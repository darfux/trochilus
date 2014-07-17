module CommonCustomer
	module ClassMethods
		def acts_as_common_customer
			#Set update_only to avoid the child being deleted
			#and cause the parent also being deleted through dependent: :destroy
	 		has_one :customer, as: :customer, dependent: :destroy, validate: true
			accepts_nested_attributes_for :customer, update_only: true	
			after_initialize :set_default_customer
			Customer.accessable_attributes.each do |name|
		  	# unless self.method_defined?(name)
		      define_method(name+'!') do
		      	self.customer.send(name)
		      end
		    # end
		  end
		end
	end
	
	module InstanceMethods

	  def set_default_customer
	  	build_customer unless self.customer #check customer.extists? to avoid loop when show .all
	  end
	end
	


	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end
# ActiveRecord::Base.send :include, ActsAsCommentable