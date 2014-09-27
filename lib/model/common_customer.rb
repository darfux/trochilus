module CommonCustomer
	module ClassMethods
		def acts_as_common_customer
			#Set update_only to avoid the child being deleted
			#and cause the parent also being deleted through dependent: :destroy
	 		has_one :customer, as: :customer, validate: true
	 		before_destroy :destroy_core
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
		attr_accessor :keep_core
	  def set_default_customer
	  	build_customer unless self.customer #check customer.extists? to avoid loop when show .all
	  end

	  def destroy_core
	  	unless keep_core
	  		customer.destroy
	  	end
	  	true
	  end
	end
	


	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end
# ActiveRecord::Base.send :include, ActsAsCommentable