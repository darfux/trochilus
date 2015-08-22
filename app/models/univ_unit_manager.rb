class UnivUnitManager < ActiveRecord::Base
  has_pin_yin_name
  belongs_to :univ_unit
  has_many :projects, foreign_key: :create_manager_id
  has_many :executed_usage_records, 
    class_name: :UsageRecord, foreign_key: :exec_manager_id
  has_many :benefitted_usage_records, 
    class_name: :UsageRecord, foreign_key: :benefit_manager_id
  validates_presence_of :name, :univ_unit
  

  before_destroy :check_relations
  def name_with_unit
    name_with_py+"(#{univ_unit.name})"
  end

  private
    def check_relations
      if projects.any? || executed_usage_records.any? || benefitted_usage_records.any?
        errors[:base] << "cannot delete manager who has any relation"
        return false
      end
      return true
    end
end
