class RenameEmployeeToCreatorOfContactRecord < ActiveRecord::Migration
  def change
    rename_column :contact_records, :employee_id, :creator_id
  end
end
