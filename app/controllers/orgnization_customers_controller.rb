class OrgnizationCustomersController < ApplicationController
  before_action :set_orgnization_customer, only: [:show, :edit, :update, :destroy]

  # GET /orgnization_customers
  # GET /orgnization_customers.json
  def index
    @orgnization_customers = OrgnizationCustomer.all
  end

  # GET /orgnization_customers/1
  # GET /orgnization_customers/1.json
  def show
  end

  # GET /orgnization_customers/new
  def new
    @orgnization_customer = OrgnizationCustomer.new
  end

  # GET /orgnization_customers/1/edit
  def edit
  end

  # POST /orgnization_customers
  # POST /orgnization_customers.json
  def create
    @orgnization_customer = OrgnizationCustomer.new(orgnization_customer_params)

    respond_to do |format|
      if @orgnization_customer.save
        format.html { redirect_to @orgnization_customer, notice: 'Orgnization customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @orgnization_customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @orgnization_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orgnization_customers/1
  # PATCH/PUT /orgnization_customers/1.json
  def update
    respond_to do |format|
      if @orgnization_customer.update(orgnization_customer_params)
        format.html { redirect_to @orgnization_customer, notice: 'Orgnization customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @orgnization_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgnization_customers/1
  # DELETE /orgnization_customers/1.json
  def destroy
    @orgnization_customer.destroy
    respond_to do |format|
      format.html { redirect_to orgnization_customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orgnization_customer
      @orgnization_customer = OrgnizationCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orgnization_customer_params
      params.require(:orgnization_customer).permit(:customer_id)
    end
end
