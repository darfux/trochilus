
module ActiveRecordExtension

  extend ActiveSupport::Concern

  # add your instance methods here

  # add your static(class) methods here
  module ClassMethods
    def validates_presence_of_all
      all = column_names - ['id', 'created_at', 'updated_at']
      validates_presence_of all
      all
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)
