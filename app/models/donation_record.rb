class DonationRecord < ActiveRecord::Base
  belongs_to :customer
  belongs_to :project
  belongs_to :fund
  belongs_to :employee
  belongs_to :donation_type
  accepts_nested_attributes_for :fund#, update_only: true
  auto_build :fund
end
