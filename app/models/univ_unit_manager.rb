class UnivUnitManager < ActiveRecord::Base
  belongs_to :univ_unit
  validates_presence_of :name, :univ_unit
  def self.all_spy
    all.sort_by{ |e| e.name_with_py }
  end
  def name_with_py
    PinYin.abbr(name)[0].upcase+'-'+name
  end
  def name_with_unit
    name_with_py+"(#{univ_unit.name})"
  end
end
