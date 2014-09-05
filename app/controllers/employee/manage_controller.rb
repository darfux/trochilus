class Employee::ManageController < ApplicationController
  def index
  end

  def projects
    tmp = (
      if current_user.account.to_s == 'fkadmin'
        Project.all
      else
        current_people.created_projects!
      end
    )
    tmp = handle_filter(tmp)
    tmp = handle_sort(tmp)
    @projects = tmp
  end

  def customers
     tmp = (
      if current_user.account.to_s == 'fkadmin'
        Customer.all
      else
        current_people.created_customers!
      end
    )
    tmp = handle_filter(tmp)
    @customers = tmp
  end

  def funds
    tmp = (
      if current_user.account.to_s == 'fkadmin'
        Fund.where('fund_instance_type != ?', 'DonationRecord').order('time DESC')
      else
        get_actual_funds(((f=params[:filters]) ? f[:fund_direction] : nil))
      end
    )
    tmp = handle_filter(tmp)
    tmp = handle_sort(tmp)
    @actual_funds = tmp
    tmp = (
      if current_user.account.to_s == 'fkadmin'
        Fund.where('fund_instance_type == ?', 'DonationRecord').order('time DESC')
      else
        get_plan_funds.order('time DESC')
      end
    ) 
    tmp = handle_filter(tmp)
    tmp = handle_sort(tmp)
    @plan_funds = tmp
  end

  def others
  end
  private

    def get_actual_funds(direction='all')
      af = ArrayRelation.new
      if direction!='out'
        draf = Fund.joins("JOIN donation_record_actual_funds ON donation_record_actual_funds.id = funds.fund_instance_id 
          AND funds.fund_instance_type = 'DonationRecord::ActualFund'").joins("JOIN donation_records ON 
          donation_record_actual_funds.donation_record_id = donation_records.id").where("donation_records.creator_id = ? ", current_user.id)
        af.concat draf
      end
      if direction!='in'
        uf = Fund.joins("JOIN usage_record_used_funds ON usage_record_used_funds.id = funds.fund_instance_id 
          AND funds.fund_instance_type = 'UsageRecord::UsedFund'").joins("JOIN usage_records ON 
          usage_record_used_funds.usage_record_id = usage_records.id").where("usage_records.creator_id = ? ", current_user.id)
        af.concat uf
      end
      af.sort_by{ |e| e.time }.reverse!
      af
    end
    def get_plan_funds
      Fund.joins("JOIN donation_records ON donation_records.id = funds.fund_instance_id 
        AND funds.fund_instance_type = 'DonationRecord'").where("donation_records.creator_id = ? ", current_user.id)
    end
end
