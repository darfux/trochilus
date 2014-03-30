class IndividualCustomersController < ApplicationController
  before_action :set_individual_customer, only: [:show, :edit, :update, :destroy]

  # GET /individual_customers
  # GET /individual_customers.json
  def index
    @individual_customers = IndividualCustomer.all
  end

  # GET /individual_customers/1
  # GET /individual_customers/1.json
  def show
  end

  # GET /individual_customers/new
  def new
    @individual_customer = IndividualCustomer.new
  end

  # GET /individual_customers/1/edit
  def edit
  end

  # POST /individual_customers
  # POST /individual_customers.json
  def create
    @individual_customer = IndividualCustomer.new(individual_customer_params)
    @individual_customer.customer = Customer.new(customer_params)
    respond_to do |format|
      if @individual_customer.save
        format.html { redirect_to @individual_customer, notice: 'Individual customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @individual_customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @individual_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /individual_customers/1
  # PATCH/PUT /individual_customers/1.json
  def update
    respond_to do |format|
      if @individual_customer.update(individual_customer_params)
        format.html { redirect_to @individual_customer, notice: 'Individual customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @individual_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /individual_customers/1
  # DELETE /individual_customers/1.json
  def destroy
    @individual_customer.destroy
    respond_to do |format|
      format.html { redirect_to individual_customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_individual_customer
      @individual_customer = IndividualCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def individual_customer_params
      begin
        params.require(:individual_customer).permit()
      rescue Exception => e
        nil
      end
    end

    def customer_params
      params.require(:customer).permit(:name, :employee_id)
    end
end
