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
    # raise current_filter.inspect
    dm = params.direct_fetch([:filters, :wk, :donation_amount], {})
    wk = []
    map = {}
    [['from','>='], ['to', '<=']].each do |t|
      if dm[t[0]]
        wk << "cus_with_amount.donation_amount #{t[1]} :dm_#{t[0]}"
        map["dm_#{t[0]}".to_sym] = dm[t[0]].to_f
      end
    end
    str=wk.join(' AND ')
    time = params.direct_fetch([:filters, :wk, :time])
    opts = {}
    if time
      opts[:time] = time.to_time_range
    end
    @customers = Customer.order(:name_abbrpy).handle_filter(current_filter).manage_view(opts)
    unless wk.empty?
      @customers = Customer.joins(%Q|INNER JOIN(#{@customers.to_sql}) cus_with_amount on cus_with_amount.id = customers.id|).where(str, map).select("customers.*", "cus_with_amount.instance_id as instance_id", 
          "cus_with_amount.schoolfellow as schoolfellow", "cus_with_amount.donation_amount as donation_amount")
    end
    @customers = @customers.page(params[:page]).per(30)
    # binding.pry
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
