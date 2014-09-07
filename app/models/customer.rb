class Customer < ActiveRecord::Base
  include PolymorphicExtension
  belongs_to :customer, polymorphic: true
  # has_and_belongs_to_many :customer_groups
  belongs_to :creator, class_name: :User
  has_many :donation_records
  has_many :contact_records

  has_many :project_link_men
  has_many :link_projects, class_name: :Project, through: :project_link_men, source: :project

  has_many :customer_group_customers
  has_many :customer_groups, through: :customer_group_customers

  validates_presence_of :name
  
  set_accessable_attributes [
    :total_donation, :contact_records, :donation_records, 
    :link_projects, :creator, :customer_groups]

  def customer_type
    super
  end
  def total_donation
    amount = 0
    self.donation_records.each do |r|
      amount+=r.plan_fund.amount
    end
    amount
  end
  def to_s
    name
  end
end
