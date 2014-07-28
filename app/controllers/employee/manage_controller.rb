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
    @actual_funds = Fund.where('fund_instance_type != ?', 'DonationRecord').order('updated_at DESC')
    @plan_funds = Fund.where('fund_instance_type == ?', 'DonationRecord').order('updated_at DESC')
  end
end
