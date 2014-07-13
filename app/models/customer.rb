class Customer < ActiveRecord::Base
  include PolymorphicExtension
  belongs_to :customer, polymorphic: true, dependent: :destroy
  has_and_belongs_to_many :customer_groups
  belongs_to :creator, class_name: "Employee"
  has_many :donation_records
  has_many :contact_records
  validates_presence_of :name
  
  set_accessable_attributes [:total_donation, :contact_records]

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
