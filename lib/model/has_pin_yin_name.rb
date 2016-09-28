module HasPinYinName
  extend ActiveSupport::Concern

  def name_with_py
    (self.try(:name_abbrpy) || PinYin.abbr(name))[0].upcase+'-'+name
  end

  protected
    def set_abbrpy
      abbr = PinYin.abbr(self.name)
      abbr[0] = 'z' if self.name[0] == '翟'
      self.name_abbrpy = abbr
    end
  
  module ClassMethods
    def has_pin_yin_name
      before_validation :set_abbrpy
    end
    def all_spy
      if column_names.include? 'name_abbrpy'
        all.order(:name_abbrpy)
      else
        all.sort_by{ |e| e.name_with_py }
      end
    end
  end
end
