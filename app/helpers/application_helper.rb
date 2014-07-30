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
  alias_method :l_d, :localize_date

  def onp
    {target: :_blank}
  end

  def del_confirm
    {method: :delete, data: { confirm: t('helpers.link.delete.confirm') }}
  end

  def default_start_year
    2005
  end
end
