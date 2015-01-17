class Fund < ActiveRecord::Base
  include PolymorphicExtension
  include FundConcern::QueryMethods
  belongs_to :currency
  belongs_to :fund_instance, polymorphic: true

  validates :amount, presence: true
  validates :time, presence: true
  validate :check_origin_amount

  filter_scopes [:select_by_type]
  filter_scoped_orders [:time, :amount, :project_py]
  filter_virtual_columns [:project_py]
  filter_where_keys [{time: {type: :time}}]

  after_initialize :defaults
  def defaults
    self.currency_id ||= Currency.CNY.id
  end

  def check_origin_amount
    if self.currency != Currency.CNY 
      errors.add_on_blank(:origin_amount) if self.origin_amount.nil?
    else
      self.origin_amount = nil
    end
  end

  def project
    case fund_instance_type
    when 'DonationRecord'
      fund_instance.project
    when 'DonationRecord::ActualFund'
      fund_instance.donation_record.project
    when 'UsageRecord::UsedFund'
      fund_instance.usage_record.project
    end
  end

  def relate_unit
    case fund_instance_type
    when 'DonationRecord'
      fund_instance.customer
    when 'DonationRecord::ActualFund'
      fund_instance.donation_record.customer
    when 'UsageRecord::UsedFund'
      fund_instance.usage_record.benefit_manager
    end
  end

  def real_amount
    case fund_instance_type
    when 'UsageRecord::UsedFund'
      -amount
    else
      amount
    end
  end
end
