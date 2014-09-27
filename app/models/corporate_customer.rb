class CorporateCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer

  has_many :corporate_link_men, dependent: :destroy
  has_many :link_men, class_name: :IndividualCustomer, through: :corporate_link_men, source: :individual_customer
  
  def self.all_spy
    all.sort_by{ |e| e.name_with_py! }
  end
end
