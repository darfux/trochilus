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
  has_many :interest_periods, class_name: :'DonationRecord::InterestPeriod', dependent: :destroy

  validates :customer, presence: true

  scope :with_fund, ->{
    joins(outerjoin_arg(:fund, :fund_instance)).select('* ,funds.*')
  }

  scope :with_actual_amount, ->{
    joins(outerjoin_arg(:actual_funds, :donation_record)).merge(DonationRecord::ActualFund.with_fund)
      .except(:select).select(%Q{#{table_name}.*, "sum(amount) as actual_amount"}).group("#{table_name}.id")
  }

  scope :with_interest_amount, ->{
    joins(outerjoin_arg(:actual_funds, :donation_record))
    .merge(DonationRecord::ActualFund.with_fund).where({"donation_record_actual_funds.fund_type_id" => FundType.interest_id})
    .except(:select).select('amount as interest_amount, donation_records.*')
    .union(
      joins(:interest_periods).merge(DonationRecord::InterestPeriod.with_amount).select('donation_records.*')
      )
  }

  scope :with_actual_funds, ->{
    joins(outerjoin_arg(:actual_funds, :donation_record)).merge(DonationRecord::ActualFund.with_fund)
  }
  
  def record
    self
  end

  def actual_amount(opts={})
    actual_funds.with_fund.where({fund_type_id: FundType.principle_id}).sum(:amount)
  end

  def interest_amount
    actual_funds.with_fund.where({fund_type_id: FundType.interest_id}).except(:select).select('amount as interest_amount')
    .union(
      self.interest_periods.with_amount
      )
    .sum(:interest_amount)
  end

  def plan_fund
    fund
  end  

  def total_amount_fund(opts={})
    return fund if opts.empty?
    Fund.where(opts.merge(id: fund.id))
  end

  def total_amount(opts={})
    return fund.amount if opts.empty?
    (f = Fund.where(opts.merge(id: fund.id))).empty? ? 0 : fund.amount
  end 
end
