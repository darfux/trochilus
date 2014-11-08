class Employee::Manage::FundController < ApplicationController
  def manage_unit
    tmp = UnivUnit.all_spy.handle_filter(current_filter)
    @manage_units = Kaminari.paginate_array(tmp).page(params[:page]).per(65)
  end
end