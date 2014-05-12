class Fund < ActiveRecord::Base
  has_one :fund_type
  belongs_to :fund_type
  belongs_to :donation_record
end
