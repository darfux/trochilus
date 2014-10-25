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
    1980
  end

  def default_end_year
    Time.now.year+5
  end

  def current_path(overwrite={})
    url_for :only_path => true, :params => params.tap{ |p| p.delete(:action);p.delete(:controller)}.merge(overwrite)
  end

  def common_form
    content_tag :div, class: "common-form" do
      yield
    end
  end

  def link_to_with(relation, scope, opts={})
    link_to relation.send(scope), relation, onp.merge(opts)
  end

  def on_admin
    current_user.account == 'fkadmin'
  end

  def money_show(amount)
    number_to_currency(amount, unit: '', raise: true)  
  end
end
