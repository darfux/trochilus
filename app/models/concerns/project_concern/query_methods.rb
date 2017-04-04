module ProjectConcern
  module QueryMethods
    extend ActiveSupport::Concern
    included do

      #http://archive.railsforum.com/viewtopic.php?id=6097#p25502
      #use entry[column.name] instead of entry.column to avoid local method
      scope :with_total_amount, ->(*opts){ joins(outerjoin_arg(:donation_records, :project)).merge(DonationRecord.with_fund(*opts))
          .except(:select).select("projects.*", "COALESCE(sum(amount), 0) as total_amount").group('projects.id') }  

      scope :with_actual_amount, ->(*opts){ joins(outerjoin_arg(:donation_records, :project)).merge(DonationRecord.with_actual_funds(*opts))
          .except(:select).select('projects.*', "sum(amount) as actual_amount").group('projects.id') }

      scope :with_interest_amount, ->(*opts){ joins(%Q|LEFT OUTER JOIN #{DonationRecord.with_interest_amount(*opts).send(:build_from).to_sql} ON "donation_records"."project_id" = "projects"."id"|)
        .select('projects.*', "COALESCE(sum(interest_amount), 0) as actual_amount").group('projects.id') 
      }

      scope :with_used, ->(*opts){
        joins(outerjoin_arg(:usage_records, :project)).merge(UsageRecord.with_amount(*opts))
        .except(:select).select('projects.*', "COALESCE(sum('interest_funds'.'amount'),0) as interest_used", "COALESCE(sum('principle_funds'.'amount'),0) as principle_used").group('projects.id') 
      }

      scope :order_by_total_amount, ->(desc=false) { with_total_amount.reorder("total_amount#{desc ? ' DESC' : ''}") }
      
      # scope :order_by_actual_amount, ->(desc=false) { with_total_amount.reorder("actual_amount#{desc ? ' DESC' : ''}") }

      scope :total_amount, ->{ donation_records.merge(DonationRecord.with_fund).sum(:amount) }

      scope :manage_view, ->(*opts){
        select("projects.*, total_amount, (total_amount-principle_used) as rest_amount,"+
          "project_levels.name as level, project_types.name as type, project_states.name as state, univ_units.name as unit,"+
          "strftime('%m-%d', necessary_dates.date) as necessary_date, necessary_dates.comment as necessary_date_comment"
          )
        .joins(%Q|INNER JOIN(#{with_total_amount(*opts).to_sql}) projects_with_total_amount on "projects".'id' == 'projects_with_total_amount'.'id'|)
        .joins(%Q|INNER JOIN(#{with_used(*opts).to_sql}) projects_with_used on "projects".'id' == 'projects_with_used'.'id'|)
        .joins(%Q|
          LEFT OUTER JOIN (
            SELECT *, MIN(date) as min_date
            FROM project_necessary_dates
            WHERE strftime( '%m-%d', COALESCE(date, julianday('1900-12-31')) ) >= strftime('%m-%d','now')
            GROUP by project_id
            ) necessary_dates on necessary_dates.project_id = projects.id and necessary_dates.date = necessary_dates.min_date
          |)
        .joins(:project_level).joins(:project_type).joins(:project_state).joins(:create_unit)
        # .where(%Q| strftime( '%m-%d', COALESCE(necessary_date, julianday('1900-12-31')) ) >= strftime('%m-%d','now')   |)

      }

    end
    module ClassMethods
    end
  end
end
