class MainController < ApplicationController
  skip_before_action :authenticate_user!, only:[:index]

  def index
    if current_user.nil?
      redirect_to login_path
    elsif current_user.user_type == 'Employee'
      redirect_to employee_manage_path
    end
  end
end
