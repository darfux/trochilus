class UnivUnit < ActiveRecord::Base
  has_pin_yin_name
  has_many :majors
  has_many :projects, foreign_key: :create_unit_id
  validates_presence_of :name
  validates_uniqueness_of :name

  # filter_where_keys [:project_type, :project_level, :create_unit, :endowment, {create_date: {type: :time}}]
  filter_method_orders [:total_amount, :actual_amount, :interest_amount, :principle_used, :interest_used, :total_used_amount]

  def total_used_amount
    principle_used + interest_used
  end

  [:total_amount, :actual_amount, :interest_amount].each do |method_name|      
    define_method(method_name) do
      amount = 0
      projects.each do |p|
        amount+=p.send(method_name)
      end
      amount
    end
  end

  def total_amount
    projects.with_total_amount.unscope(:group).sum(:amount)
  end

  def actual_amount
    projects.with_actual_amount.unscope(:group).sum(:amount)
  end

  def interest_amount
    projects.with_interest_amount.unscope(:group).sum(:interest_amount)
  end

  [:principle_used, :interest_used].each do |method_name|
    type = method_name.to_s.split('_')[0]
    type_id = FundType.where(name: type).take
    define_method(method_name) do         
      amount = 0                   
      projects.each do |p|
        amount += p.send(method_name)
      end
      amount
    end
  end

end
