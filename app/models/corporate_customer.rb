class CorporateCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer

  def self.ch
    '公司客户'
  end
end
