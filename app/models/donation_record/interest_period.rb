class DonationRecord::InterestPeriod < ActiveRecord::Base
  belongs_to :donation_record
  validates_presence_of_all except: [:comment]

  scope :with_amount, ->(opts={}){ 
    time = opts[:time]
    joins(:donation_record).merge(DonationRecord.with_actual_funds)
    .except(:select).select(
    "sum(max(( (strftime('%Y',#{case_time('end', time, false)})-strftime('%Y',#{case_time('start', time)})  )*12 +"\
    "(strftime('%m',#{case_time('end', time, false)})-strftime('%m', #{case_time('start', time)}) ) ), 0)/12.0"\
    "*(rate/100.0) *amount) as interest_amount"
    ) # use max() to avoid nagative duration 
  }

  def self.case_time(col, time, start=true)
    case time
    when nil
      return %Q{ #{col} }
    when Range
      time = start ? time.begin.to_date : time.end.to_date
    when Time
      time = time.to_date
    end   
    %Q{ (case when julianday(#{col})-julianday('#{time}')#{start ? '<' : '>'}0 then '#{time}' else #{col} end) }
  end
  private_class_method :case_time

  def rate!
    rate/100
  end

  def amount
    DonationRecord.with_interest_amount.where("donation_records.id": donation_record.id).sum(:interest_amount)
  end
  
  def months
    start.month_before(self.end)
  end
end
