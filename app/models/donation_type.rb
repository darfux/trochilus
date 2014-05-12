class DonationType < ActiveRecord::Base
  has_many :donation_records
  attr_accessible :name
end
