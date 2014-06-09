class UsageRecord < ActiveRecord::Base
  belongs_to :fund
  belongs_to :employee
  belongs_to :project
  belongs_to :exec_unit, class_name: :UnivUnit
  belongs_to :exec_manager, class_name: :UnivUnitManager
  belongs_to :benefit_unit, class_name: :UnivUnit
  belongs_to :benefit_manager, class_name: :UnivUnitManager
  belongs_to :usage_type

  accepts_nested_attributes_for :fund
  auto_build :fund
  # attr_accessible :title, :body
end
