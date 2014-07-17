class RenameEmployeeOfProjectToCreator < ActiveRecord::Migration
  def change
    rename_column :projects, :employee_id, :creator_id
  end
end
