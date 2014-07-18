class CustomerGroupCustomer < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_group
  validates_uniqueness_of :customer_id, scope: [:customer_group_id]
end
