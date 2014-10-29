module ModelFilterControllerExtension
  extend ActiveSupport::Concern

  def current_filter
    ModelFilter.new(params)
  end
  module ClassMethods
  end
end