class Employee::ManageController < ApplicationController
  include ModelFilterControllerExtension
  def index
  end

  def projects
    tmp = Project.all.order(:name_abbrpy).handle_filter(current_filter)
    # tmp = handle_sort(tmp)
    @total_amount = @rest_amount = 0
    tmp.each { |p| @total_amount+=p.total_amount; @rest_amount+=p.principle_rest }
    @projects = Kaminari.paginate_array(tmp).page(params[:page]).per(25)
    # @projects = tmp
  end

  def customers
    @customers = Customer.all.order(:name_abbrpy).handle_filter(current_filter)
  end

  def funds
    filters = params.fetch(:filters, {}).dup.tap{ |f| f.delete(:fund_direction) }
    tmp = (
      if true||current_user.account.to_s == 'fkadmin'
        case params.direct_fetch([:filters, :fund_direction])
        when 'in'
          Fund.where('fund_instance_type == ?', 'DonationRecord::ActualFund').order('time DESC')
        when 'out'
          Fund.where('fund_instance_type == ?', 'UsageRecord::UsedFund').order('time DESC')
        else
          Fund.where('fund_instance_type != ?', 'DonationRecord').order('time DESC')
        end
      else
        get_actual_funds(params.direct_fetch([:filters, :fund_direction]))
      end
    )
    tmp = handle_filter(tmp, filters)
    tmp = handle_sort(tmp)
    @actual_funds = tmp
    tmp = (
      if true||current_user.account.to_s == 'fkadmin'
        Fund.where('fund_instance_type == ?', 'DonationRecord').order('time DESC')
      else
        get_plan_funds.order('time DESC')
      end
    ) 
    tmp = handle_filter(tmp, filters)
    tmp = handle_sort(tmp)
    @plan_funds = tmp
  end

  def others
  end

  def search
    @search = SearchObject.new
    @search.type = DonationRecord::ActualFund.search_type(:serialnum)
  end

  def result
    @search = SearchObject.new
    @search.attributes = search_params
    case @search.type
    when DonationRecord::ActualFund.search_type(:serialnum)
      @results = DonationRecord::ActualFund.where(serialnum: @search.query)
      render 'donation_record_actual_fund_serialnum_result'
    when Fund.search_type(:amount)
      @results = Fund.where(amount: @search.query).order('time DESC')
      render 'fund_amount_result'
    end
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
