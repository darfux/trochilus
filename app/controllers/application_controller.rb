class ApplicationController < ActionController::Base
  before_action :set_current_user
  layout :set_layout
  # before_filter :authorize
  protect_from_forgery
  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to root_url
      end
    end

    def current_user_id
      User.find(session[:user_id]).user_id
    end

    def set_layout
      return session[:user_type].to_s if session[:user_type]
      "application"
    end

    def set_current_user
      case session[:user_type]
      when :employee
        @current_user = Employee.find(current_user_id)
      end
    end
end
