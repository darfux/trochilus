class Employee::ManageController < ApplicationController
  def index
    
  end

  def projects

    tmp = Project.all.order(:name_abbrpy).manage_view.handle_filter(current_filter)
    @tmp = current_filter
    @total_amount = @rest_amount = 0
    # @projects = Kaminari.paginate_array(tmp).page(params[:page]).per(100)
    @projects = tmp.page(params[:page]).per(30)

    #NTBI
    @total_amount = tmp.sum('total_amount')
    @rest_amount = tmp.sum('total_amount-principle_used')
  end

  def customers
    @customers = Customer.all.order(:name_abbrpy).handle_filter(current_filter)
  end

  def funds
    tmp = (
      if params[:type].nil? || params[:type]=='actual'
        Fund.select_by_type(Fund.poly_types.actual_all)
      else
        Fund.select_by_type(Fund.poly_types.plan)
      end
    )
    tmp = tmp.manage_view.order('time DESC').handle_filter(current_filter)
    @total_amount = tmp.sum("case funds.fund_instance_type when 'UsageRecord::UsedFund' then -funds.amount else funds.amount end")
    @funds = tmp.page(params[:page]).per(30)
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

end
