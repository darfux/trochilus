
module ActiveRecordExtension

  extend ActiveSupport::Concern

  # add your instance methods here

  # add your static(class) methods here
  module ClassMethods
    def validates_presence_of_all(*args, except: [])
      all = column_names - (['id', 'created_at', 'updated_at'] + Array(except)).collect{|e| e.to_s}
      validates_presence_of all
      all
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)
