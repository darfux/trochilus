module SimpleReflector
  def self.included(r)
    ActiveRecord::Base.send(:include, self::ActiveRecordExtension)
  end
end