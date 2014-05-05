# encoding: utf-8
class IndividualCustomer < ActiveRecord::Base
	# include CommonCustomer
 #  common_customer_acts
 		has_one :customer, as: :customer, dependent: :destroy, validate: true
		accepts_nested_attributes_for :customer, update_only: true	
		after_initialize :set_default_customer
  # accepts_nested_attributes_for :customer 
  def set_default_customer
  	build_customer unless self.customer
  end
  def self.ch
    "个人客户"
  end
end
