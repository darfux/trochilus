class Item < ActiveRecord::Base
  belongs_to :item_donation_record
  belongs_to :item_category
  has_pin_yin_name

  validates_presence_of :item_donation_record
  validates_presence_of :name
  validates_presence_of :amount
  
end
