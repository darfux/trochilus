class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :type_change, :edit_type]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    redirect_to @customer.customer
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @customers = IndividualCustomer.all
    render '_search'
  end

  def do_search
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

  def edit_type
  end
  def type_change
    new_type_class = params[:new_type].classify.constantize
    unless new_type_class==@customer.customer.class
      # raise params[:new_type]
      instance = @customer.customer
      instance.keep_core = true
      instance.destroy
      new_customer = new_type_class.new
      new_customer.customer = @customer
      @customer.customer = new_customer
      new_customer.save!
      @customer.save!
    end
    # binding.pry
    redirect_to @customer.customer
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id]||params[:customer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :customer_id, :customer_type)
    end
end
