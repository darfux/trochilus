class OnlineCustomersController < ApplicationController
  before_action :set_online_customer, only: [:show, :edit, :update, :destroy]

  # GET /online_customers
  # GET /online_customers.json
  def index
    @online_customers = OnlineCustomer.all
  end

  # GET /online_customers/1
  # GET /online_customers/1.json
  def show
  end

  # GET /online_customers/new
  def new
    @online_customer = OnlineCustomer.new
  end

  # GET /online_customers/1/edit
  def edit
  end

  # POST /online_customers
  # POST /online_customers.json
  def create
    @online_customer = OnlineCustomer.new(online_customer_params)

    respond_to do |format|
      if @online_customer.save
        format.html { redirect_to @online_customer, notice: 'Online customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @online_customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @online_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /online_customers/1
  # PATCH/PUT /online_customers/1.json
  def update
    respond_to do |format|
      if @online_customer.update(online_customer_params)
        format.html { redirect_to @online_customer, notice: 'Online customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @online_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /online_customers/1
  # DELETE /online_customers/1.json
  def destroy
    @online_customer.destroy
    respond_to do |format|
      format.html { redirect_to online_customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_online_customer
      @online_customer = OnlineCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def online_customer_params
      params.require(:online_customer).permit(:customer_id)
    end
end
