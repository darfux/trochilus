class IndividualCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer

  has_many :corporate_link_men
  has_many :link_corporates, class_name: :CorporateCustomer, through: :corporate_link_men, source: :corporate_customer
end
