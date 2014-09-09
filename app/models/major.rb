class Major < ActiveRecord::Base
  belongs_to :univ_unit
  validates_presence_of :name
end
