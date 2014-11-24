module CustomerConcern
  module QueryMethods
    extend ActiveSupport::Concern
    included do
      scope :manage_view, ->{
        select("customers.*", "COALESCE(individual_customers.id, corporate_customers.id, customer_groups.id) as instance_id", 
          "schoolfellows.id as schoolfellow")
        .joins( oja(customer: IndividualCustomer) )
        .joins( IndividualCustomer.oja(:schoolfellow) )
        .joins( oja(customer: CorporateCustomer) )
        .joins( oja(customer: CustomerGroup ) )
      }
    end
  end
end