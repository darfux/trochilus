class UsageRecord < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :project
  belongs_to :exec_unit, class_name: :UnivUnit
  belongs_to :exec_manager, class_name: :UnivUnitManager
  belongs_to :benefit_unit, class_name: :UnivUnit
  belongs_to :benefit_manager, class_name: :UnivUnitManager
  belongs_to :usage_type
  belongs_to :fund_type
  
  has_many :attachments, as: :attachment_owner, validate: true
  validates_presence_of_all except: :fund_id
end
