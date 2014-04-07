class SessionController < ApplicationController
  # layout "admin", :except => [:index, :login]
  skip_before_filter :authorize
  def index
  end
  def login
    if User.find_by_account(params[:account]).authenticate(params[:password])
      redirect_to employee_manage_path
    else
      redirect_to root_url
    end
  end
end
