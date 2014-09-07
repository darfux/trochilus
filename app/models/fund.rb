class Fund < ActiveRecord::Base
  include PolymorphicExtension
  belongs_to :currency

  belongs_to :fund_instance, polymorphic: true

  # has_one :donation_record_actual_fund
  # has_one :donation_record_actual, class_name: :DonationRecord, through: :donation_record_actual_fund, source: :donation_record

  # accepts_nested_attributes_for :donation_record_plan

  validates :amount, presence: true
  validates :time, presence: true

  after_initialize :defaults
  def defaults
    self.currency = Currency.where(symbol: :RMB).first
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
    when 'DonationRecord', 'DonationRecord::ActualFund'
      amount
    when 'UsageRecord::UsedFund'
      -amount
    end
  end
end
