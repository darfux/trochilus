class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :set_layout
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:account, :email, :password, :password_confirmation) }
    end

    def current_people
      @current_people ||= current_user ? current_user.user : nil
    end
    
    def set_layout
      return current_people.user_type!.downcase.to_s if current_people
      "application"
    end
end
