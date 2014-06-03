class DonationRecord < ActiveRecord::Base
  belongs_to :customer
  belongs_to :project
  belongs_to :plan_fund, class_name: :Fund, :foreign_key => :plan_fund_id
  belongs_to :employee
  belongs_to :donation_type

  has_many :donation_record_actual_funds
  has_many :actual_funds, through: :donation_record_actual_funds, source: :fund

  validates :customer_id, presence: true

  accepts_nested_attributes_for :plan_fund#, update_only: true
  auto_build :plan_fund
  
  def actual_amount
    actual_amount = 0
    self.actual_funds.each do |a|
      actual_amount+=a.amount
    end
    actual_amount
  end
end
