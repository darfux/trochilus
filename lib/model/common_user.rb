module CommonUser
	module ClassMethods
		def acts_as_common_user
			#Set update_only to avoid the child being deleted
			#and cause the parent also being deleted through dependent: :destroy
	 		has_one :user, as: :user, dependent: :destroy, validate: true

			accepts_nested_attributes_for :user, update_only: true	
			after_initialize :set_default_user

			User.accessable_attributes.each do |name|
		  	# unless self.method_defined?(name)
		      define_method(name+'!') do
		      	self.user.send(name)
		      end
		    # end
		  end
		end
	end
	
	module InstanceMethods

	  def set_default_user
	  	build_user unless self.user #check customer.extists? to avoid loop when show .all
	  end

	  def method_missing(methId, *args)
	  	user.send(methId, args)
	  end
	end
	


	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end