class CustomerGroupsController < CommonCustomersController
  before_action :set_customers, only: [:new]
  @@Customer_labels[:name] = :团体名称
  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    # def customer_group_params
    #   params.require(:customer_group).permit()
    # end
    def set_customers
      @customers = Customer.all.collect{ |c| c.customer }
    end
end
