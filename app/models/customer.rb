class Customer < ActiveRecord::Base
  belongs_to :customer, polymorphic: true, dependent: :destroy
  # belongs_to :customer_type
  belongs_to :employee
  has_many :donation_records
  attr_accessible :name, :employee_id
  validates_presence_of :name
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
  def self.accessable_attributes
    self.column_names << "total_donation"
  end
  def to_s
    name
  end
end