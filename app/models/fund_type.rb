class FundType < ActiveRecord::Base
  has_many :funds

  all.each do |type|
    self.class.class_eval(%Q{
      def #{type.name}_id
        #{type.id}
      end
    })
  end

end
