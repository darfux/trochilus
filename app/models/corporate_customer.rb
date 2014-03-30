class CorporateCustomer < ActiveRecord::Base
  has_one :customers, as: :customer
end
