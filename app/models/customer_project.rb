class CustomerProject < ActiveRecord::Base
  has_many :donation_records
  has_one :customer
  has_one :project
end
