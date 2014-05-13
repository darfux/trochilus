class OrgnizationCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer
end
