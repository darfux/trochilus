class Fund < ActiveRecord::Base
  include PolymorphicExtension
  belongs_to :fund_type
  belongs_to :donation_record_plan, class_name: :DonationRecord, :foreign_key => :plan_fund_id
  belongs_to :currency
  belongs_to :usage_record

  has_one :donation_record_actual_fund
  has_one :donation_record_actual, class_name: :DonationRecord, through: :donation_record_actual_fund, source: :donation_record
  accepts_nested_attributes_for :donation_record_plan

  validates :amount, presence: true

  after_initialize :defaults
  def defaults
    self.currency = Currency.where(symbol: :RMB).first
  end
end
