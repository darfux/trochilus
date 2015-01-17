module SimpleReflector
  def self.use
    ActiveRecord::Base.send(:include, self::ActiveRecordExtension)
  end
end