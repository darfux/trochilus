class Customer < ActiveRecord::Base
  belongs_to :customer, polymorphic: true, dependent: :destroy
  has_and_belongs_to_many :customer_groups
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
    #don't use << to append!!
    #see more: https://ruby-china.org/topics/10084
    self.column_names + ["total_donation"]
  end
  def to_s
    name
  end
end