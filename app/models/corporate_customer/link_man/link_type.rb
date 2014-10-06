class CorporateCustomer::LinkMan::LinkType < ActiveRecord::Base
  
  all.each do |type|
    self.class.class_eval(%Q{
      def #{type.name}_id
        #{type.id}
      end
    })
  end

end
