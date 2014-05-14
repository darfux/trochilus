class Fund < ActiveRecord::Base
  has_one :fund_type
  belongs_to :fund_type
  belongs_to :donation_record, :foreign_key => :plan_fund_id
  belongs_to :currency
  has_one :donation_record, through: :donation_record_actual_fund
  after_initialize :defaults

  def defaults
    self.currency = Currency.where(symbol: :RMB).first
  end
end
