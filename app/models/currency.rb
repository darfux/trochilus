class Currency < ActiveRecord::Base
  has_many :funds
end
