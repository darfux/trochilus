class OrgnizationCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer
  def self.ch
    '组织客户'
  end
end
