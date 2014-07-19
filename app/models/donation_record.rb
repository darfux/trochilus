class DonationRecord < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  # alias_method :plan_fund, :fund 

  belongs_to :customer
  belongs_to :project
  belongs_to :creator, class_name: :Employee, foreign_key: :creator_id
  belongs_to :donation_type

  has_many :actual_funds, class_name: :'DonationRecord::ActualFund'
  # has_many :actual_funds, through: :donation_record_actual_funds, source: :fund, dependent: :destroy, validate: true

  validates :customer_id, presence: true
  # validates_associated :actual_funds
  
  def actual_amount
    actual_amount = 0
    principle = FundType.where(name: '本金').first
    self.actual_funds.where(fund_type_id: principle.id).each do |a|
      actual_amount+=a.amount!
    end
    actual_amount
  end
  
  def interest_amount
    interest_amount = 0
    interest = FundType.where(name: '利息').first
    self.actual_funds.where(fund_type_id: interest.id).each do |a|
      interest_amount+=a.amount!
    end
    interest_amount
  end
  def plan_fund
    fund
  end
  def plan_fund_type
  end
  def actual_intreset_fund_type
  end
end
