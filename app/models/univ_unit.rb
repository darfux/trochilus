class UnivUnit < ActiveRecord::Base
  include UnivUnitConcern::QueryMethods
  has_pin_yin_name
  has_many :majors
  has_many :projects, foreign_key: :create_unit_id
  validates_presence_of :name
  validates_uniqueness_of :name

  filter_scoped_orders [:total_amount, :actual_amount, :interest_amount]
  filter_virtual_columns [:total_amount, :actual_amount, :interest_amount]
  filter_method_orders [ :principle_used, :interest_used, :total_used_amount]

  def total_used_amount
    principle_used + interest_used
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
