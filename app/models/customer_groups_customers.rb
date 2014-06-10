class CustomerGroupsCustomers < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_group
  # attr_accessible :title, :body
end
