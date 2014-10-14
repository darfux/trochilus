class DonationRecord < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  # alias_method :plan_fund, :fund 

  belongs_to :customer
  belongs_to :project
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :donation_type

  has_many :actual_funds, ->{ merge(DonationRecord::ActualFund.join_funds) }, class_name: :'DonationRecord::ActualFund', dependent: :destroy
  has_many :attachments, as: :attachment_owner, validate: true, dependent: :destroy
  has_many :interest_periods, ->{ order(:start) }, class_name: :'DonationRecord::InterestPeriod'
  
  validates :customer, presence: true
  # validates :donation_type, presence: true
  # validates_associated :actual_funds
  
  def record
    self
  end
  
  # def actual_funds(opts={})
  #   opts.dup.each_pair do |k, v|
  #     if Fund.method_defined? k
  #       opts.delete k
  #       opts["#{Fund.table_name}.#{k}"] = v
  #     end
  #   end
  #   self.actual_funds.merge(DonationRecord::ActualFund.join_funds)
  # end

  def self.actual_funds(opts={})
    joins('LEFT OUTER JOIN "donation_records_actual_funds" ON "donation_records_actual_funds"."donation_record_id" = "donation_records"."id" ').merge(DonationRecord::ActualFund.join_funds)
  end

  def self.funds(opts={})
    joins(outer_join_fund_arg).select('* ,funds.* as donation_record_funds.*')
  end

  def actual_amount(opts={})
    actual_funds.where({fund_type_id: FundType.principle_id}).sum(:amount)
  end

  def interest_amount
    interest_amount = 0
    interest_amount += actual_funds.where({fund_type_id: FundType.interest_id}).sum(:amount)
    self.interest_periods.each do |ip|
      interest_amount+=ip.amount
    end
    interest_amount
  end

  # def interest_amount(opts={})
  #   opts.dup.each_pair do |k, v|
  #     if Fund.method_defined? k
  #       opts.delete k
  #       opts["#{Fund.table_name}.#{k}"] = v
  #     end
  #   end
  #   interest_amount = 0
  #   self.actual_funds
  #   .joins(DonationRecord::ActualFund.join_fund_arg)
  #   .where({fund_type_id: FundType.interest_id}.merge(opts)).each do |a|
  #     interest_amount+=a.amount!
  #   end
  #   self.interest_periods.each do |ip|
  #     interest_amount+=ip.amount
  #   end
  #   interest_amount
  # end

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
