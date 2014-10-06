class CorporateCustomers::LinkMenController < ApplicationController
  before_action :set_customer, except: [:search]
  before_action :set_link_man, only: [:show, :destroy]
  def show

  end

  def new
    @customers = IndividualCustomer.all
  end

  def create
    linkmen = params[:customer] || []
    linkmen.each do |l_id|
      begin
        @customer.link_men<< CorporateCustomer::LinkMan.new( 
          individual_customer_id: l_id, corporate_customer_id: params[:corporate_customer_id], 
          corporate_customer_link_man_type_id: params[:type])
      rescue
        raise '123'
      end
    end
    redirect_to @customer
  end

  def edit
  end

  def destroy
    @customer.link_men.delete(@link_man)
    redirect_to @customer
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
      format.html
    end
  end

  private
    def set_customer
      @customer = CorporateCustomer.find(params[:corporate_customer_id])
    end
    
    def set_link_man
      @link_man  = CorporateCustomer::LinkMan.find(params[:id])
    end
end
