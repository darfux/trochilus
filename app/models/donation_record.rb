class DonationRecord < ActiveRecord::Base
  belongs_to :customer
  belongs_to :project
  belongs_to :plan_fund, class_name: :Fund, :foreign_key => :plan_fund_id, dependent: :destroy
  belongs_to :employee
  belongs_to :donation_type

  has_many :donation_record_actual_funds
  has_many :actual_funds, through: :donation_record_actual_funds, source: :fund, dependent: :destroy, validate: true

  validates :customer_id, presence: true
  validates_associated :plan_fund, :actual_funds

  accepts_nested_attributes_for :plan_fund#, update_only: true
  auto_build :plan_fund
  
  def actual_amount
    actual_amount = 0
    principle = FundType.where(name: '本金').first
    self.actual_funds.where(fund_type_id: principle.id).each do |a|
      actual_amount+=a.amount
    end
    actual_amount
  end
  
  def interest_amount
    interest_amount = 0
    interest = FundType.where(name: '利息').first
    self.actual_funds.where(fund_type_id: interest.id).each do |a|
      interest_amount+=a.amount
    end
    interest_amount
  end
end
