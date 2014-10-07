class CorporateCustomer::LinkMan::LinkType < ActiveRecord::Base
  
  all.each do |type|
    self.class.class_eval(%Q{
      def #{type.name}_id
        #{type.id}
      end
    })
  end

  def name_t
    return '普通' if name=='ordinary'
    return '负责人' if name=='manager'
  end
end
