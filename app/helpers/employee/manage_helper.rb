module Employee::ManageHelper
  def judge_sf(c)
    return false unless c.customer.class == IndividualCustomer
    c.customer.schoolfellow ? true : false
  end
end
