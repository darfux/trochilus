class Region::Country < ActiveRecord::Base
  include HasPinYinName
  has_many :states, class_name: 'Region::State', foreign_key: :region_country_id
  validates_uniqueness_of :name
  skip_callback :validate, :before, :set_abbrpy
end
