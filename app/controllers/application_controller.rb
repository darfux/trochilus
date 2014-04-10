class ApplicationController < ActionController::Base
  layout :set_layout
  # before_filter :authorize
  protect_from_forgery
  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to root_url
      end
    end
    def user_employee
      Employee.find(User.find(session[:user_id]).user_id)
    end
    def set_layout
      return session[:user_type].to_s if session[:user_type]
      "application"
    end
end
