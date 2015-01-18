class ItemCategory < ActiveRecord::Base
  has_pin_yin_name
  validates_uniqueness_of :name
end
