class RenameEmployeeOfUsageRecordToCreator < ActiveRecord::Migration
  def change
    rename_column :usage_records, :employee_id, :creator_id
  end
end
