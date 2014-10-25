class Region::City < ActiveRecord::Base
  include HasPinYinName
  belongs_to :region_state
  validates_presence_of :name
  validates_uniqueness_of :name,  scope: [:region_state]
  skip_callback :validate, :before, :set_abbrpy
end
