class Employee::Manage::FundController < ApplicationController
  def manage_unit
    tmp = UnivUnit.all_spy
    @manage_units = handle_sort(tmp)
  end
end