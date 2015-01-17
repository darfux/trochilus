class Employee::Manage::FundController < ApplicationController
  def manage_unit
    tmp = UnivUnit.all_spy.handle_filter_with_amounts(current_filter)
    @manage_units = Kaminari.paginate_array(tmp).page(params[:page]).per(65)
  end
  def undetermined_fund
    @undetermined_funds = 
      Fund.select_by_type(Fund.poly_types.undetermined).handle_filter(current_filter)
  end
end