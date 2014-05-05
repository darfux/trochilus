class CommonCustomersController < ApplicationController
  before_action :set_self_active_record, except: [:employee_add_customer]
  before_action :set_self_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_back_path
  # GET /self_customers
  # GET /self_customers.json
  def index
    @self_customers = @SelfActiveRecord.all
  end

  # GET /self_customers/1
  # GET /self_customers/1.json
  def show
  end

  # GET /self_customers/new
  def new
    # raise flash.inspect
    @self_customer = @SelfActiveRecord.new
    render 'common_customers/new'
  end

  # GET /self_customers/1/edit
  def edit
  end

  # POST /self_customers
  # POST /self_customers.json
  def create
    @self_customer = @SelfActiveRecord.new(self_params) #using :child:_attributes for nested
    # @self_customer.customer = @self_customer.build_customer(customer_params)

    respond_to do |format|
      if @self_customer.save
        format.html { redirect_to @self_customer, notice: 'Individual customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @self_customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @self_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /self_customers/1
  # PATCH/PUT /self_customers/1.json
  def update
    # @self_customer.customer = @self_customer.update_attributes_customer(customer_params)
    respond_to do |format|
      # success = @self_customer.transaction do
      #   @self_customer.customer.update_attributes(customer_params)
      #   @self_customer.update_attributes(self_customer_params)
      # end
      if @self_customer.update_attributes(self_params)
        format.html { redirect_to @self_customer, notice: 'Individual customer was successfully updated.' }
        format.json { head :no_content }
      else
        raise 'wrong update'
        format.html { render action: 'edit' }
        format.json { render json: @self_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /self_customers/1
  # DELETE /self_customers/1.json
  def destroy
    @self_customer.destroy
    respond_to do |format|
      format.html { redirect_to self.send("#{}") }
      format.json { head :no_content }
    end
  end

  protected
    def set_back_path
      @back_path = flash[:from]
    end

    def set_self_active_record
      @SelfActiveRecord = Object.const_get(self.class.to_s.gsub("Controller","").singularize)
    end

    def set_self_customer
      @self_customer = @SelfActiveRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def self_params
      params.require(@SelfActiveRecord.to_s.underscore.to_sym).
        permit(customer_attributes:[:name]).tap{ |p| p[:customer_attributes][:employee_id] = @current_user.id }
    end
end