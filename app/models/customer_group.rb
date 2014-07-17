class CustomerGroup < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer
  has_many :customers
end
