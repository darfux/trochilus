class Project < ActiveRecord::Base
  belongs_to :project_level
  belongs_to :project_state
  belongs_to :project_type
  belongs_to :employee, class_name: :Employee, foreign_key: :creator_id

  has_many :project_link_men
  has_many :link_men, class_name: :Customer, through: :project_link_men, source: :customer
  has_many :donation_records
  has_many :usage_records

  has_many :attachments, as: :attachment_owner, validate: true

  validates_presence_of :name
  
  validates_associated :link_men
  validates_associated :project_link_men
  
  def endowment_t
    e = endowment ? :eyes : :eno
    I18n.translate(e, scope: 'project.endowment')
  end

  # def #{pre}_amount
  #   amount = 0
  #   donation_records.each do |d|
  #     amount+=d.#{pre}_amount
  #   end
  #   amount
  # end
  [:total_amount, :actual_amount, :interest_amount].each do |method_name|      
    define_method(method_name) do             
      amount = 0                                
      donation_records.each do |r|                
        amount+=r.send(method_name)               
      end
      amount
    end
  end

  [:principle_used, :interest_used].each do |method_name|
    type = method_name.to_s.split('_')[0]
    type_id = FundType.where(name: type).take
    define_method(method_name) do             
      amount = 0                                
      usage_records = UsageRecord.where(fund_type_id: type_id)
      usage_records.each do |r|
        amount += r.fund.amount
      end
      amount
    end
  end

end