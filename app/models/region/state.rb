class Region::State < ActiveRecord::Base
  belongs_to :region_country
  has_many :cities, class_name: 'Region::City', foreign_key: :region_state_id
  validates_presence_of :name
  validates_uniqueness_of :name,  scope: [:region_country]
end
