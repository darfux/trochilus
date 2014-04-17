class PathTable
  url = Rails.application.routes.url_helpers
  @@DATA = {
    employee:{
      customer: :employee_add_customer
    }
  }
  def self.find(user_type, action)
    @@DATA[user_type][action]
  end
end