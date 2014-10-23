class DonationRecord::InterestPeriod < ActiveRecord::Base
  belongs_to :donation_record
  validates_presence_of_all except: [:comment]

  scope :with_amount, ->{ joins(:donation_record).merge(DonationRecord.with_fund)
    .except(:select).select(
    "( (strftime('%Y',end)-strftime('%Y',start)  )*12 +"\
    "(strftime('%m',end)-strftime('%m',start) ) )/12.0"\
    "*(rate/100.0)*amount as interest_amount"
    ) 
  }

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
