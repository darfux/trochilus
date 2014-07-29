module Employee::ManageHelper
  def judge_sf(c)
    return false unless c.customer.class == IndividualCustomer
    c.customer.schoolfellow ? true : false
  end
  def decorate_amount(amount)
    html = (
      if amount>=0
        content_tag(:td, amount, :class => 'fund-amount-show positive')
      else
        content_tag(:td, amount, :class => 'fund-amount-show negative')
      end
    )
  end
end
