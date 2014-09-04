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
    @actual_funds = handle_sort(tmp)
    tmp = (
      if current_user.account.to_s == 'fkadmin'
        Fund.where('fund_instance_type == ?', 'DonationRecord').order('time DESC')
      else
        get_plan_funds.order('time DESC')
      end
    ) 
    @plan_funds = handle_sort(tmp)
  end

  def others
  end
  private
    def handle_sort(relation)
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
    def handle_filter(relation)
      # binding.pry
      f = params[:filters]
      f && f.each_pair do |k,v| 
        f[k] = true   if v=='true'
        f[k] = false  if v=='false'
      end
      relation.where(f)
    end
    def get_actual_funds(direction='all')
      af = []
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
    end
    def get_plan_funds
      Fund.joins("JOIN donation_records ON donation_records.id = funds.fund_instance_id 
        AND funds.fund_instance_type = 'DonationRecord'").where("donation_records.creator_id = ? ", current_user.id)
    end
end
