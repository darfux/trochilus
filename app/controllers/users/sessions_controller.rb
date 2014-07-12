class Users::SessionsController < Devise::SessionsController
  def create
    # super
    super do |resource|
      # raise current_user.inspect
    end
  end
end