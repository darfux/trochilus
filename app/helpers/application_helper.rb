module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_people
    @current_people ||= (current_user ? current_user.user : nil)
  end

  def lt(*args)
    args[0] = args[0].getlocal
    l(*args)
  end
  
  def localize_date(time)
    time.localtime.strftime("%Y-%m-%d")
  end
end
