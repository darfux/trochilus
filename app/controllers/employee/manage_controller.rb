class Employee::ManageController < ApplicationController
  def index
  end

  def projects
    relation = (
      if current_user.account.to_s == 'fkadmin'
        Project.all
      else
        current_people.created_projects!
      end
    )
    @projects = handle_sort(relation)
  end

  def customers
    @customers = (
      if current_user.account.to_s == 'fkadmin'
        Customer.all.reverse
      else
        current_people.created_customers!.reverse
      end
    )
  end

  def funds
    @actual_funds = (
      if current_user.account.to_s == 'fkadmin'
        Fund.where('fund_instance_type != ?', 'DonationRecord').order('updated_at DESC')
      else
        get_actual_funds
      end
    )
    @plan_funds = (
      if current_user.account.to_s == 'fkadmin'
        Fund.where('fund_instance_type == ?', 'DonationRecord').order('updated_at DESC')
      else
        get_plan_funds
      end
    ) 
  end

  def others
  end
  private
    def handle_sort(relation)
      relation
      unless col = params[:col]
        relation
      else
        desc = params[:sort]=='1' ? true : false
        # binding.pry
        tmp = relation.sort_by{|p| p.send(col)}
        tmp = tmp.reverse if desc
        tmp
      end
    end
    def get_actual_funds
      draf = Fund.joins("JOIN donation_record_actual_funds ON donation_record_actual_funds.id = funds.fund_instance_id 
        AND funds.fund_instance_type = 'DonationRecord::ActualFund'").joins("JOIN donation_records ON 
        donation_record_actual_funds.donation_record_id = donation_records.id").where("donation_records.creator_id = ? ", current_user.id)
      uf = Fund.joins("JOIN usage_record_used_funds ON usage_record_used_funds.id = funds.fund_instance_id 
        AND funds.fund_instance_type = 'UsageRecord::UsedFund'").joins("JOIN usage_records ON 
        usage_record_used_funds.usage_record_id = usage_records.id").where("usage_records.creator_id = ? ", current_user.id)
      (draf+uf).sort_by{ |e| e.created_at }.reverse!
    end
    def get_plan_funds
      Fund.joins("JOIN donation_records ON donation_records.id = funds.fund_instance_id 
        AND funds.fund_instance_type = 'DonationRecord'").where("donation_records.creator_id = ? ", current_user.id).to_a.reverse!
    end
end
