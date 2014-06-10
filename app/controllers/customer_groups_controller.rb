class CustomerGroupsController < CommonCustomersController
  @@Customer_labels[:name] = :团体名称
  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    # def customer_group_params
    #   params.require(:customer_group).permit()
    # end
end
