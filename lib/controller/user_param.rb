module UserParam
  def user_params
    params.require(:user).permit(:account, :password, :password_confirm, :user_id)
  end
end