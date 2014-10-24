class CustomerGroupsController < CommonCustomersController
  before_action :set_group, only: [:delete_customer]
  before_action :set_delete_customer, only: [:delete_customer]
  def create
    @self_customer = @SelfActiveRecord.new(self_params)
    @self_customer.customer.creator = current_user
    customers = params[:customer] || []
    customers.each do |c_id|
      customer = IndividualCustomer.find(c_id).customer
      begin
        @self_customer.customers<<customer
      rescue
        next
      end
    end
    respond_to do |format|
      if @self_customer.save
        format.html { redirect_to @self_customer, notice: 'Customer group was successfully created.' }
        format.json { render :show, status: :created, location: @self_customer }
      else
        format.html { render :new }
        format.json { render json: @self_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    customers = params[:customer] || []
    customers.each do |c_id|
      customer = IndividualCustomer.find(c_id).customer
      begin
        @self_customer.customers<<customer
      rescue
        next
      end
    end
    set_self_customer #reset the state of group to avoid duplicate validate of customers
    respond_to do |format|
      if @self_customer.update(self_params)
        format.html { redirect_to @self_customer, notice: 'Individual customer was successfully updated.' }
        format.json { head :no_content }
      else
        # raise 'wrong update'
        format.html { render action: 'edit' }
        format.json { render json: @self_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_customer
    @group.customers.delete @customer
    redirect_to @group
  end
  private
    def set_group
      @group = CustomerGroup.find(params[:customer_group_id])
    end
    def set_delete_customer
      @customer = Customer.find(params[:id])
    end
end
