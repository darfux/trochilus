class UsageRecord::UsedFund < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance
  
  belongs_to :usage_record
  belongs_to :fund_type
end
