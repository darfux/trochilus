class UsersController < ApplicationController
  def search
    search_name = params[:search]
    # raise params[:search].inspect
    # project = Project.find(params[:project_id])
    unless search_name
      @customers = IndividualCustomer.all
    else
      @customers = Customer.where(
        "name LIKE ? AND customer_type = ?", "%#{search_name}%", IndividualCustomer.to_s).collect{ |c| c.customer }
    end
    respond_to do |format|
      format.js
    end
  end
end
