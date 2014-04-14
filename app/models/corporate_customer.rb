class CorporateCustomer < ActiveRecord::Base
  has_one :customers, as: :customer, dependent: :destroy, validate: true
end
