class UnivUnit < ActiveRecord::Base
  include UnivUnitConcern::QueryMethods
  has_pin_yin_name
  has_many :majors
  has_many :projects, foreign_key: :create_unit_id
  validates_presence_of :name
  validates_uniqueness_of :name

  filter_scoped_orders [:total_amount, :actual_amount, :interest_amount, :principle_used, :interest_used, :total_used_amount]
  filter_virtual_columns [:total_amount, :actual_amount, :interest_amount, :principle_used, :interest_used, :total_used_amount]
  filter_method_orders []

  def total_used_amount
    projects.with_used.unscope(:group).sum("COALESCE(interest_funds.amount, 0) + COALESCE(principle_funds.amount, 0)")
  end

  [:principle_used, :interest_used].each do |method_name|
    type = method_name.to_s.split('_')[0]
    define_method(method_name) do         
      projects.with_used.unscope(:group).sum("#{type}_funds.amount")
    end
  end

end
