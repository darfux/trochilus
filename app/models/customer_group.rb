class CustomerGroup < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer
  
  has_and_belongs_to_many :customers
  # accepts_nested_attributes_for :customer 

  def self.ch
    "团体客户"
  end
end
