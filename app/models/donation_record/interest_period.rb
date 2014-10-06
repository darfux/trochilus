class DonationRecord::InterestPeriod < ActiveRecord::Base
  belongs_to :donation_record
  validates_presence_of_all except: [:comment]

  def rate!
    rate/100
  end
  def amount
    donation_record.amount! * rate! * start.month_before(self.end) / 12.0
  end
  def months
    start.month_before(self.end)
  end
end
