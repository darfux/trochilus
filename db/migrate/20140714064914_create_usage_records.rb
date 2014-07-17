class CreateUsageRecords < ActiveRecord::Migration
  def change
    create_table :usage_records do |t|
      t.references :fund, index: true
      t.references :employee, index: true
      t.references :project, index: true
      t.references :exec_unit, index: true
      t.references :exec_manager, index: true
      t.references :benefit_unit, index: true
      t.references :benefit_manager, index: true
      t.references :usage_type, index: true

      t.timestamps
    end
  end
end
