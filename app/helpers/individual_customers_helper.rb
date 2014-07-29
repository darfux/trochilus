module IndividualCustomersHelper
  def lkt(*args)
    t(*args, scope: 'helpers.link.individual_customer')
  end
  def default_gender
    return 1 if @self_customer.gender.nil?
    @self_customer.gender ? 1 : 0
  end
end
