class CorporateCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer

  has_many :corporate_link_men
  has_many :link_men, class_name: :IndividualCustomer, through: :corporate_link_men, source: :individual_customer
end
