class OnlineCustomer < ActiveRecord::Base
  has_one :customer, as: :customer
end
