module UnivUnitConcern
  module QueryMethods
    extend ActiveSupport::Concern
    included do
      scope :with_total_amount, ->(*opts){
        joins(outerjoin_arg(:projects, :create_unit)).merge(Project.with_total_amount(*opts))
        .unscope(:group, :select)
        .select(%Q|"univ_units".*, COALESCE(SUM('funds'.'amount'),0) as total_amount|)
        .group('univ_units.id')
      }
      scope :with_actual_amount, ->(*opts){
        joins(outerjoin_arg(:projects, :create_unit)).merge(Project.with_actual_amount(*opts))
        .unscope(:group, :select)
        .select(%Q|"univ_units".*, COALESCE(SUM('funds'.'amount'),0) as actual_amount|)
        .group('univ_units.id')
      }
      scope :with_interest_amount, ->(*opts){
        joins(outerjoin_arg(:projects, :create_unit)).merge(Project.with_interest_amount(*opts))
        .unscope(:group, :select)
        .select(%Q|"univ_units".*, COALESCE(SUM('donation_records'.'interest_amount'),0) as interest_amount|)
        .group('univ_units.id')
      }

      scope :with_used, ->(*opts){
        joins(outerjoin_arg(:projects, :create_unit)).merge(Project.with_used(*opts))
        .unscope(:group, :select)
        .select(%Q|"univ_units".*, COALESCE(sum('interest_funds'.'amount'),0) as interest_used, COALESCE(sum('principle_funds'.'amount'),0) as principle_used| )
        .group('univ_units.id')
      }
      scope :with_amounts, ->(*opts){
        select("univ_units.*, actual_amount, interest_amount, interest_used, principle_used, (interest_used + principle_used) as total_used_amount")
        .joins(%Q|INNER JOIN(#{with_actual_amount(*opts).to_sql}) univ_units_with_actual_amount on "univ_units".'id' == 'univ_units_with_actual_amount'.'id'|)
        .joins(%Q|INNER JOIN(#{with_interest_amount(*opts).to_sql}) univ_units_with_inerest on "univ_units".'id' == 'univ_units_with_inerest'.'id'|)
        .joins(%Q|INNER JOIN(#{with_used(*opts).to_sql}) univ_units_with_used on "univ_units".'id' == 'univ_units_with_used'.'id'|)
      }

      scope :handle_filter_with_amounts, ->(filters){
        with_amounts( time: filters.where_keys[:time].try(:to_time_range) ).handle_filter(filters)
      }

    end
    module ClassMethods
    end
  end
end
