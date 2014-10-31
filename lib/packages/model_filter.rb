module ModelFilter
  def self.use
    ActiveRecord::Base.send(:include, self::ActiveRecordExtension)
    ActionController::Base.send(:include, self::ControllerExtension)
  end
end