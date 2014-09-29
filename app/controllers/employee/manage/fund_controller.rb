class Employee::Manage::FundController < ApplicationController
  def manage_unit
    tmp = UnivUnit.all_spy
    if time = params.direct_fetch([:filters, :time])
      @filter = {time: gen_time_range(time)}
      tmp.each do |u| # ~ 0.05 ms cost
        u.set_filter @filter
      end
    end
    @manage_units = handle_sort(tmp)
  end
end