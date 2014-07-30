class DonationRecord < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  # alias_method :plan_fund, :fund 

  belongs_to :customer
  belongs_to :project
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :donation_type

  has_many :actual_funds, class_name: :'DonationRecord::ActualFund', dependent: :destroy
  has_many :attachments, as: :attachment_owner, validate: true, dependent: :destroy
  
  validates :customer, presence: true
  # validates :donation_type, presence: true
  # validates_associated :actual_funds
  
  def actual_amount
    actual_amount = 0
    principle = FundType.where(name: :principle).take
    self.actual_funds.where(fund_type_id: principle.id).each do |a|
      actual_amount+=a.amount!
    end
    actual_amount
  end
  
  def interest_amount
    interest_amount = 0
    interest = FundType.where(name: :interest).take
    self.actual_funds.where(fund_type_id: interest.id).each do |a|
      interest_amount+=a.amount!
    end
    interest_amount
  end
  def plan_fund
    fund
  end  
  def total_amount
    fund.amount
  end
end
