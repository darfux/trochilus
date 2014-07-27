module IndividualCustomersHelper
  def lkt(*args)
    t(*args, scope: 'helpers.link.individual_customer')
  end
end
