module HasPinYinName
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
  
  module InstanceMethods
    def name_with_py
      PinYin.abbr(name)[0].upcase+'-'+name
    end

    protected
      def set_abbrpy
        self.name_abbrpy = PinYin.abbr(self.name)
      end
  end
  

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

ActiveRecord::Base.send(:include, HasPinYinName)