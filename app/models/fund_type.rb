class FundType < ActiveRecord::Base
  has_many :funds
  attr_accessible :name
end
