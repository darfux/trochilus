class CorporateCustomer::LinkMan < ActiveRecord::Base
  belongs_to :corporate_customer
  belongs_to :individual_customer
  belongs_to :corporate_customer_link_man_link_type, class_name: 'CorporateCustomer::LinkMan::LinkType'

  alias_attribute :instance, :individual_customer
  alias_attribute :type, :corporate_customer_link_man_link_type
  
  validates_uniqueness_of :individual_customer,  scope: [:corporate_customer]
end
