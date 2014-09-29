class UnivUnit < ActiveRecord::Base
  has_many :majors
  has_many :projects, foreign_key: :create_unit_id
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_spy
    all.sort_by{ |e| e.name_with_py }
  end
  
  def name_with_py
    PinYin.abbr(name)[0].upcase+'-'+name
  end

  def total_used_amount
    principle_used + interest_used
  end

  def set_filter(filters)
    @filter = filters
  end

  [:total_amount, :actual_amount, :interest_amount].each do |method_name|      
    define_method(method_name, 
      ->(opts = {}, *splat, &block) do
        amount = 0
        opts.merge! @filter if @filter
        projects.each do |p|
          amount+=p.send(method_name, opts)
        end
        amount
      end
    )
  end

  [:principle_used, :interest_used].each do |method_name|
    type = method_name.to_s.split('_')[0]
    type_id = FundType.where(name: type).take
    define_method(method_name,
      ->(opts = {}, *splat, &block) do         
        amount = 0
        opts.merge! @filter if @filter                      
        projects.each do |p|
          amount += p.send(method_name, opts)
        end
        amount
      end
    )
  end

end
