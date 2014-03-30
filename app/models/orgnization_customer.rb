class OrgnizationCustomer < ActiveRecord::Base
  has_one :customer, as: :customer
end
