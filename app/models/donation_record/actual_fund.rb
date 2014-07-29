class DonationRecord::ActualFund < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  belongs_to :donation_record
  belongs_to :fund_type

  #If using with the :through option, the association on the join model must be a belongs_to, 
  #and the records which get deleted are the join records, rather than the associated records.
  # has_one :fund, as: :fund_instance, dependent: :destroy, validate: true
end
