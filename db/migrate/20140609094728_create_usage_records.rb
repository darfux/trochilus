class CreateUsageRecords < ActiveRecord::Migration
  def change
    create_table :usage_records do |t|
      t.references :fund
      t.references :employee
      t.references :project
      t.references :exec_unit
      t.references :exec_manager
      t.references :benefit_unit
      t.references :benefit_manager
      t.references :usage_type

      t.timestamps
    end
    add_index :usage_records, :fund_id
    add_index :usage_records, :employee_id
    add_index :usage_records, :project_id
    add_index :usage_records, :exec_unit_id
    add_index :usage_records, :exec_manager_id
    add_index :usage_records, :benefit_unit_id
    add_index :usage_records, :benefit_manager_id
    add_index :usage_records, :usage_type_id
  end
end
