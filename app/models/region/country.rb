class Region::Country < ActiveRecord::Base
  has_many :states, class_name: 'Region::State', foreign_key: :region_country_id
  validates_uniqueness_of :name
end
