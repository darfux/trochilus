class SessionController < ApplicationController
  # layout "admin", :except => [:index, :login]
  skip_before_filter :authorize
  def index
  end
  def login
    redirect_to employee_manage_path
  end
end
