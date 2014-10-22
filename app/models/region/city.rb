class Region::City < ActiveRecord::Base
  belongs_to :region_state
  validates_presence_of :name
  validates_uniqueness_of :name,  scope: [:region_state]
end
