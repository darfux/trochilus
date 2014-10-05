class UnivUnitManager < ActiveRecord::Base
  has_pin_yin_name
  belongs_to :univ_unit
  validates_presence_of :name, :univ_unit
  
  def name_with_unit
    name_with_py+"(#{univ_unit.name})"
  end
end
