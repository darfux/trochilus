module ProjectsHelper
  def get_all_plan(project)
    amount = 0
    project.donation_records.each do |d|
      amount += d.plan_fund.amount
    end
    amount
  end
  def get_all_actual(project)
    amount = 0
    project.donation_records.each do |d|
      amount += d.actual_amount
    end
    amount
  end
end
