module CommonFundInstance
	module ClassMethods
		def acts_as_common_fund_instance
			#Set update_only to avoid the child being deleted
			#and cause the parent also being deleted through dependent: :destroy
	 		has_one :fund, as: :fund_instance, dependent: :destroy, validate: true
			accepts_nested_attributes_for :fund, update_only: true	
			after_initialize :set_default_fund
			Fund.accessable_attributes.each do |name|
		  	# unless self.method_defined?(name)
		      define_method(name+'!') do
		      	self.fund.send(name)
		      end
		    # end
		  end
		end
	  def join_fund_arg
			"JOIN funds ON funds.fund_instance_id = #{self.table_name}.id AND \
	  			funds.fund_instance_type = '#{self.to_s}'"
	  end
	end
	
	module InstanceMethods

	  def set_default_fund
	  	build_fund unless self.fund #check fund.extists? to avoid loop when show .all
	  end

	end
	


	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end
# ActiveRecord::Base.send :include, ActsAsCommentable