class PathTable
  url = Rails.application.routes.url_helpers
  @@DATA = {
    employee:{
      customer: url.employee_add_customer_path
    }
  }
  def self.find(user_type, action)
    @@DATA[user_type][action]
  end
end