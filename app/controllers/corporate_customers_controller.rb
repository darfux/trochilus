class CorporateCustomersController < CommonCustomersController
  before_action :set_corporate_customer, only: [:show, :edit, :update, :destroy]

  # GET /corporate_customers
  # GET /corporate_customers.json
  def index
    @corporate_customers = CorporateCustomer.all
  end

  # GET /corporate_customers/1
  # GET /corporate_customers/1.json
  def show
  end

  # GET /corporate_customers/new
  def new
    @corporate_customer = CorporateCustomer.new
  end

  # GET /corporate_customers/1/edit
  def edit
  end

  # POST /corporate_customers
  # POST /corporate_customers.json
  def create
    @corporate_customer = CorporateCustomer.new(corporate_customer_params)

    respond_to do |format|
      if @corporate_customer.save
        format.html { redirect_to @corporate_customer, notice: 'Corporate customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @corporate_customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @corporate_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corporate_customers/1
  # PATCH/PUT /corporate_customers/1.json
  def update
    respond_to do |format|
      if @corporate_customer.update(corporate_customer_params)
        format.html { redirect_to @corporate_customer, notice: 'Corporate customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @corporate_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporate_customers/1
  # DELETE /corporate_customers/1.json
  def destroy
    @corporate_customer.destroy
    respond_to do |format|
      format.html { redirect_to corporate_customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corporate_customer
      @corporate_customer = CorporateCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corporate_customer_params
      params.require(:corporate_customer).permit(:customer_id)
    end
end
