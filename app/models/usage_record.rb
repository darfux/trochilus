class UsageRecord < ActiveRecord::Base

  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :project
  belongs_to :exec_unit, class_name: :UnivUnit
  belongs_to :exec_manager, class_name: :UnivUnitManager
  belongs_to :benefit_unit, class_name: :UnivUnit
  belongs_to :benefit_manager, class_name: :UnivUnitManager
  belongs_to :usage_type
  belongs_to :fund_type
  
  has_one :interest_fund, ->{ where(fund_type_id: FundType.find_by(name: :interest).id) } , 
    class_name: :'UsageRecord::UsedFund', dependent: :destroy, validate: true
  has_one :principle_fund, ->{ where(fund_type_id: FundType.find_by(name: :principle).id) } , 
    class_name: :'UsageRecord::UsedFund', dependent: :destroy, validate: true
  has_many :attachments, as: :attachment_owner, validate: true, dependent: :destroy


  accepts_nested_attributes_for :interest_fund, update_only: true
  accepts_nested_attributes_for :principle_fund, update_only: true

  # auto_build :interest_fund, :principle_fund if oncreate
  after_initialize :set_default_fund
  validates_presence_of_all except: [:interest_fund, :principle_fund, :comment]
  validate :at_least_one_fund

  def set_default_fund
    return if UsageRecord.exists? self
    build_interest_fund unless self.interest_fund
    build_principle_fund unless self.principle_fund
  end
  
  def both_funds
    [self.interest_fund, self.principle_fund]
  end

  def at_least_one_fund
    if [self.interest_fund, self.principle_fund].reject(&:nil?).size == 0
      errors.add(:both_funds, :blank)
    end
  end 

  ['principle', 'interest'].each do |type|
    method_name = "#{type}_amount".to_sym
    define_method(method_name,
      ->(opts = {}, *splat, &block) do
        if (f = self.send("#{type}_fund")).nil?
          0
        else
          if opts.empty?
            f.amount!
          else
            (tmp = Fund.where(opts.merge(id: f.id!))).empty? ? 0 : f.amount!
          end
        end
      end
    )
    alias_method "#{type}_used".to_sym, method_name
  end


  # alias_method :principle_used
  # def principle_amount
  #   (f = principle_fund).nil? ? 0 : f.fund.amount
  # end

  # def interest_amount
  #   (f = interest_fund).nil? ? 0 : f.fund.amount
  # end

  def time
    f = principle_fund || interest_fund
    f.fund.time
  end
end
