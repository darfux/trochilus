class IndividualCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer

  has_one :schoolfellow, dependent: :destroy, validate: true
  belongs_to :corporate, class_name: "CorporateCustomer", foreign_key: :corporate_customer_id
  has_many :corporate_link_men, dependent: :destroy
  has_many :link_corporates, class_name: :CorporateCustomer, through: :corporate_link_men, source: :corporate_customer
  def gender_t
    gender ? '男' : '女'
  end
end
