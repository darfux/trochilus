class UnivUnit < ActiveRecord::Base
  has_many :majors
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_spy
    all.sort_by{ |e| e.name_with_py }
  end
  
  def name_with_py
    PinYin.abbr(name)[0].upcase+'-'+name
  end
end
