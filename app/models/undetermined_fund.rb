class UndeterminedFund < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance
  include UndeterminedFundConcern::QueryMethods
end
