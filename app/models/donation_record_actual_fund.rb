class DonationRecordActualFund < ActiveRecord::Base
  belongs_to :donation_record
  belongs_to :fund
end
