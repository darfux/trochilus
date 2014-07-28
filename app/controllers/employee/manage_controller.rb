class Employee::ManageController < ApplicationController
  def index
  end

  def projects
    @projects = current_people.created_projects!
  end

  def customers
    @customers = current_people.created_customers!
  end

  def funds
  end
end
