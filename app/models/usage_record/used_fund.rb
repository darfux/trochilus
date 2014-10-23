class UsageRecord::UsedFund < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance
  
  belongs_to :usage_record
  belongs_to :fund_type
  
  scope :with_fund, ->{ joins(join_arg(:fund, :fund_instance)).select('* ,funds.*') }

  def project
    usage_record.project
  end
  def record
    usage_record
  end
end
