class Employee::Manage::FundController < ApplicationController
  def manage_unit
    tmp = UnivUnit.all_spy
    @manage_units = handle_sort(tmp)
    if time = params.direct_fetch([:filters, :time])
      @filter = {time: gen_time_range(time)}
    end
  end
end