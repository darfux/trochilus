module ModelFilter
  def self.use
    ActiveRecord::Base.send(:include, self::ActiveRecordExtension)
    ActionController::Base.send(:include, self::ControllerExtension)
    ActionController::Base.send(:before_filter, 
      -> { self.class.helper ModelFilter::ViewHelpers }
    )
  end
end