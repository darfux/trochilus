class SessionController < ApplicationController
  # layout "admin", :except => [:index, :login]
  skip_before_filter :authorize
  def index
    # raise self.send(PathTable.find(:employee, :customer).to_s).to_s
  end
  def login
    user = User.find_by_account(params[:account])
    if user&&user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_type] = :employee
      redirect_to employee_manage_path
    else
      redirect_to root_url
    end
  end
end
