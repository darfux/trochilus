class UnivUnit < ActiveRecord::Base
  has_many :majors
  validates_presence_of :name
  validates_uniqueness_of :name
end
