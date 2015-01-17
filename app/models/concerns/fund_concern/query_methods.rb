module FundConcern
  module QueryMethods
    extend ActiveSupport::Concern
    included do
      POLY_TYPE = OpenStruct.new.tap do |t|
        t.plan  = :plan
        t.actual_in   = :in
        t.actual_out  = :out
        t.actual_all  = :all
        t.undetermined  = :undeter
      end

      scope :select_by_type, ->(type=nil){
        unscope(where: :fund_instance_type)
        .where *(
          case type.to_sym
          when POLY_TYPE.actual_in
            ['fund_instance_type == ?', 'DonationRecord::ActualFund']
          when POLY_TYPE.actual_out
            ['fund_instance_type == ?', 'UsageRecord::UsedFund']
          when POLY_TYPE.actual_all
            ['fund_instance_type == ? OR fund_instance_type == ?', 'DonationRecord::ActualFund', 'UsageRecord::UsedFund']
          when POLY_TYPE.plan
            ['fund_instance_type == ?', 'DonationRecord']
          when POLY_TYPE.undetermined
            ['fund_instance_type == ?', 'UndeterminedFund']
          else
            raise 'wrong type'
          end
        )
      }

      scope :manage_view, ->{
        select("projects.name as project_name", "projects.id as project_id", "projects.name_abbrpy as project_py","funds.*",
          "COALESCE(customers.name, univ_unit_managers.name) as relate_name", 
          "COALESCE(customers.id, univ_unit_managers.id) as relate_id", 
          "(case  when customers.id is not null then 'customer' else 'manager' end) as relate_type")
        .joins( oja({fund_instance: DonationRecord})              )
        .joins( oja({fund_instance: DonationRecord::ActualFund})  )
        .joins( oja({fund_instance: UsageRecord::UsedFund})       )
        .joins( oja({fund_instance: UsageRecord::UsedFund})       )
        .joins( UsageRecord::UsedFund.oja(:usage_record)          )
        .joins( DonationRecord::ActualFund.oja(donation_record: {as: :af_owner}) )
        .joins( UsageRecord.oja(:exec_manager) )
        .joins( "LEFT OUTER JOIN customers on COALESCE(af_owner.customer_id, donation_records.customer_id) = customers.id")
        .joins('JOIN projects on COALESCE(donation_records.project_id, usage_records.project_id, af_owner.project_id) = projects.id')
      }
    end
    module ClassMethods
      def poly_types
        POLY_TYPE
      end
    end
  end
end