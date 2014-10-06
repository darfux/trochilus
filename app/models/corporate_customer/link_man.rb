class CorporateCustomer::LinkMan < ActiveRecord::Base
  belongs_to :corporate_customer
  belongs_to :individual_customer

  alias_attribute :instance, :individual_customer
  
  validates_uniqueness_of :individual_customer,  scope: [:corporate_customer]
end
