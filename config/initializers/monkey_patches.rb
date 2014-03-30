module AbstractController
  module Callbacks
    module ClassMethods
      alias_method :before_action, :before_filter
    end
  end
end