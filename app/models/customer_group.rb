class CustomerGroup < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer
  has_many :customer_group_customers, dependent: :destroy
  has_many :customers, through: :customer_group_customers
end
