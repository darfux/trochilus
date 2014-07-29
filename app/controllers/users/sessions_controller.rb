class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!
  def create
    # super
    super do |resource|
      # raise current_user.inspect
    end
  end
  def after_sign_out_path_for(arg)
    login_path if arg==:user
  end
end