class LinkMenController < ApplicationController
  before_action :set_project, except: [:search]
  before_action :set_link_man, only: [:show, :destroy]
  def show

  end

  def new
    @customers = IndividualCustomer.all
  end

  def create
    # raise params.inspect
    customers = params[:customer] || []
    customers.each do |c_id|
      customer = IndividualCustomer.find(c_id).customer
      begin
        @project.link_men<<customer
      rescue
        next
      end
    end
    redirect_to @project
  end

  def edit
  end

  def destroy
    @project.link_men.delete(@link_man.customer)
    redirect_to @project
  end

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

  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    
    def set_link_man
      @link_man  = Customer.find(params[:id]).customer
    end
end
