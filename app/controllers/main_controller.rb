class MainController < ApplicationController
  def index
    if current_user.user_type == 'Employee'
      redirect_to employee_manage_path
    end
  end
end
