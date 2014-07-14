class DonationRecordActualFund < ActiveRecord::Base
  belongs_to :donation_record

  #If using with the :through option, the association on the join model must be a belongs_to, 
  #and the records which get deleted are the join records, rather than the associated records.
  belongs_to :fund, dependent: :destroy
end
