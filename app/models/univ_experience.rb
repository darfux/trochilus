class UnivExperience < ActiveRecord::Base
  belongs_to :schoolfellow
  belongs_to :major
  belongs_to :degree
  belongs_to :univ_unit

  alias_attribute :college, :univ_unit
  validates_presence_of_all
end
