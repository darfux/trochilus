module CommonCustomersHelper
  def get_back_path(default)
    case session[:user_type]
    when nil
      default
    else
      PathTable.find(session[:user_type], :customer)
    end
  end

  def get_self_path
    self.send("#{@SelfActiveRecord.to_s.tableize}_path")
  end
end
