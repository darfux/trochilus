class Project < ActiveRecord::Base
  audited except: [:name_abbrpy, :creator_id]
  has_pin_yin_name
  belongs_to :project_level
  belongs_to :project_state
  belongs_to :project_type
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :create_unit, class_name: :UnivUnit, foreign_key: :create_unit_id
  belongs_to :create_manager, class_name:  :UnivUnitManager, foreign_key: :create_manager_id

  has_many :project_link_men, dependent: :destroy
  has_many :link_men, class_name: :Customer, through: :project_link_men, source: :customer
  has_many :donation_records, dependent: :destroy
  has_many :usage_records, dependent: :destroy
  has_many :news, dependent: :destroy

  has_many :attachments, as: :attachment_owner, validate: true, dependent: :destroy
  
  validates_associated :link_men
  validates_associated :project_link_men

  validates_presence_of :project_level
  validates_presence_of_all except: [:interest_rate, :endowment, :brief, :serialnum, :create_manager, :comment]

  scope :with_total_amount, ->{ joins(outerjoin_arg(:donation_records, :project)).merge(DonationRecord.with_fund)
      .except(:select).select('projects.*', "sum(ifnull(amount, 0)) as total_amount").group('projects.id') }  

  scope :with_actual_amount, ->{ joins(outerjoin_arg(:donation_records, :project)).merge(DonationRecord.with_actual_funds)
      .except(:select).select('projects.*', "sum(amount) as actual_amount").group('projects.id') }

  #http://archive.railsforum.com/viewtopic.php?id=6097#p25502
  #use entry[column.name] instead of entry.column to avoid local method
  scope :order_by_total_amount, ->(desc=false) { with_total_amount.reorder("total_amount#{desc ? ' DESC' : ''}") }
  
  # scope :order_by_actual_amount, ->(desc=false) { with_total_amount.reorder("actual_amount#{desc ? ' DESC' : ''}") }

  scope :total_amount, ->{ donation_records.merge(DonationRecord.with_fund).sum(:amount) }

  def endowment_t
    e = endowment ? :eyes : :eno
    I18n.translate(e, scope: 'project.endowment')
  end
  
  def self.attribute_show(key, value)
    attribute = foreign_keys[key.to_sym]
    return value unless attribute
    Project.new(key => value).send(attribute).name
  end

  def actual_funds
    donation_records.merge(DonationRecord.with_actual_amount.except(:group))
  end
  
  def total_amount(opts={})
    donation_records.merge(DonationRecord.with_fund).sum(:amount)
  end

  def actual_amount(opts={})
    actual_funds.sum(:amount)
  end


  alias_method :principle_amount, :total_amount

  def interest_amount(opts={})
    amount = 0
    donation_records.each do |r|
      amount+=r.interest_amount
    end
    amount
  end

  [:principle_used, :interest_used].each do |method_name|
    type = method_name.to_s.split('_')[0]
    type_id = FundType.where(name: type).take
    define_method(method_name,
     ->(opts = {}, *splat, &block) do                
        amount = 0                                
        usage_records.each do |r|
          amount += r.send(method_name, opts)
        end
        amount
      end
    )
  end

  [:principle_rest, :interest_rest].each do |method_name|
    type = method_name.to_s.split('_')[0]
    define_method(method_name,
     ->(opts = {}, *splat, &block) do                
        self.send("#{type}_amount") - self.send("#{type}_used")
      end
    )
  end

  def self.handle_filter(filters, relation=nil)
    @where_keys ||= [:project_type, :project_level, :create_unit, :endowment]
    scopes  = filters.scopes
    sort    = filters.sort
    where_conditions = filters.get_where_conditions(@where_keys)
    relation = (relation||self).where(where_conditions)
    desc = sort.desc
    desc_sql = sort.desc_sql

    @scoped_orders = [:order_by_total_amount, :order_by_actual_amount, :create_date]
    @method_orders = [:principle_rest]
    sa=sort.attribute
    if @scoped_orders.include? sa
      relation = relation.send(sa, desc)
      # binding.pry
    end
    if @method_orders.include? sa
      tmp = relation.sort_by{|p| p.principle_rest}
      tmp.reverse! if desc
      relation = tmp
    end
    relation.to_a
  end

end