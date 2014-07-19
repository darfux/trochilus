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

  def localize_time(time)
    time.localtime.strftime("%Y-%m-%d %H:%M")
  end
  
  def localize_date(time)
    time.localtime.strftime("%Y-%m-%d")
  end
end
