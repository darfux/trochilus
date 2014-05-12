# encoding: utf-8
class IndividualCustomer < ActiveRecord::Base
	include CommonCustomer
 	acts_as_common_customer

  # accepts_nested_attributes_for :customer 

  def self.ch
    "个人客户"
  end
end
