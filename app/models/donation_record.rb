class DonationRecord < ActiveRecord::Base
  belongs_to :customer_project
  belongs_to :fund
  belongs_to :employee
  belongs_to :donation_type
  accepts_nested_attributes_for :fund#, update_only: true
  accepts_nested_attributes_for :customer_project#, update_only: true
  auto_build :customer_project
  auto_build :fund
end
