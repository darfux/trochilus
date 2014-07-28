class Employee::ManageController < ApplicationController
  def index
  end

  def projects
    @projects = current_people.created_projects!
  end

  def customers
    @customers = current_people.created_customers!
  end

  def funds
    @actual_funds = (
      draf = Fund.joins("JOIN donation_record_actual_funds ON donation_record_actual_funds.id = funds.fund_instance_id 
        AND funds.fund_instance_type = 'DonationRecord::ActualFund'").joins("JOIN donation_records ON 
        donation_record_actual_funds.donation_record_id = donation_records.id").where("donation_records.creator_id = ? ", current_user.id)
      uf = Fund.joins("JOIN usage_record_used_funds ON usage_record_used_funds.id = funds.fund_instance_id 
        AND funds.fund_instance_type = 'UsageRecord::UsedFund'").joins("JOIN usage_records ON 
        usage_record_used_funds.usage_record_id = usage_records.id").where("usage_records.creator_id = ? ", current_user.id)
      (draf+uf).sort_by{ |e| e.created_at }.reverse!
    )
    @plan_funds = Fund.joins("JOIN donation_records ON donation_records.id = funds.fund_instance_id 
      AND funds.fund_instance_type = 'DonationRecord'").where("donation_records.creator_id = ? ", current_user.id).to_a.reverse!
  end
end
