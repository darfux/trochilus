class Fund < ActiveRecord::Base
  include PolymorphicExtension
  belongs_to :currency

  belongs_to :fund_instance, polymorphic: true

  # has_one :donation_record_actual_fund
  # has_one :donation_record_actual, class_name: :DonationRecord, through: :donation_record_actual_fund, source: :donation_record

  # accepts_nested_attributes_for :donation_record_plan

  validates :amount, presence: true
  validates :time, presence: true
  validate :check_origin_amount

  POLY_TYPE = OpenStruct.new.tap do |t|
    t.plan  = :plan
    t.actual_in   = :in
    t.actual_out  = :out
    t.actual_all  = :all
  end

  def self.poly_types
    POLY_TYPE
  end

  scope :select_by_type, ->(type=nil){
    unscope(where: :fund_instance_type)
    .where *(
      case type.to_sym
      when POLY_TYPE.actual_in
        ['fund_instance_type == ?', 'DonationRecord::ActualFund']
      when POLY_TYPE.actual_out
        ['fund_instance_type == ?', 'UsageRecord::UsedFund']
      when POLY_TYPE.actual_all
        ['fund_instance_type != ?', 'DonationRecord']
      when POLY_TYPE.plan
        ['fund_instance_type == ?', 'DonationRecord']
      else
        raise 'wrong type'
      end
    )
  }

  scope :manage_view, ->{
    joins(oja({fund_instance: DonationRecord}))
    .joins(oja({fund_instance: DonationRecord::ActualFund}))
    .joins(oja({fund_instance: UsageRecord::UsedFund}))
  }

  filter_scopes [:select_by_type]
  filter_scoped_orders [:time, :amount]
  filter_method_orders [:project_py]
  filter_where_keys [{time: {type: :time}}]

  after_initialize :defaults
  def defaults
    self.currency_id ||= Currency.CNY.id
  end


  def check_origin_amount
    if self.currency != Currency.CNY 
      errors.add_on_blank(:origin_amount) if self.origin_amount.nil?
    else
      self.origin_amount = nil
    end
  end

  def project
    case fund_instance_type
    when 'DonationRecord'
      fund_instance.project
    when 'DonationRecord::ActualFund'
      fund_instance.donation_record.project
    when 'UsageRecord::UsedFund'
      fund_instance.usage_record.project
    end
  end

  def project_py
    project.name_with_py
  end

  def relate_unit
    case fund_instance_type
    when 'DonationRecord'
      fund_instance.customer
    when 'DonationRecord::ActualFund'
      fund_instance.donation_record.customer
    when 'UsageRecord::UsedFund'
      fund_instance.usage_record.benefit_manager
    end
  end

  def real_amount
    case fund_instance_type
    when 'DonationRecord', 'DonationRecord::ActualFund'
      amount
    when 'UsageRecord::UsedFund'
      -amount
    end
  end
end
