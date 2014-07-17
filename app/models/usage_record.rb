class UsageRecord < ActiveRecord::Base
  belongs_to :fund, dependent: :destroy
  belongs_to :creator, class_name: :Employee, foreign_key: :creator_id
  belongs_to :project
  belongs_to :exec_unit, class_name: :UnivUnit
  belongs_to :exec_manager, class_name: :UnivUnitManager
  belongs_to :benefit_unit, class_name: :UnivUnit
  belongs_to :benefit_manager, class_name: :UnivUnitManager
  belongs_to :usage_type

  validates_associated :fund

  validates_presence_of_all except: :fund_id

  accepts_nested_attributes_for :fund
  auto_build :fund

end
