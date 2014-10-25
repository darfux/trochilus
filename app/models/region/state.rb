class Region::State < ActiveRecord::Base
  include HasPinYinName
  belongs_to :region_country
  has_many :cities, class_name: 'Region::City', foreign_key: :region_state_id
  validates_presence_of :name
  validates_uniqueness_of :name,  scope: [:region_country]
  skip_callback :validate, :before, :set_abbrpy
end
