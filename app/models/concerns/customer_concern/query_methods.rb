module CustomerConcern
  module QueryMethods
    extend ActiveSupport::Concern
    included do
      scope :manage_view, ->(opts={}){
        select("customers.*", "COALESCE(individual_customers.id, corporate_customers.id, customer_groups.id) as instance_id", 
          "schoolfellows.id as schoolfellow", "sum(COALESCE(funds.amount, 0)) as donation_amount")
        .joins( oja(customer: IndividualCustomer) )
        .joins( IndividualCustomer.oja(:schoolfellow) )
        .joins( oja(customer: CorporateCustomer) )
        .joins( oja(customer: CustomerGroup ) )
        .joins( oja(:donation_records) ).merge(DonationRecord.with_fund(opts).except(:select))
        .group('customers.id')
      }
    end
  end
end