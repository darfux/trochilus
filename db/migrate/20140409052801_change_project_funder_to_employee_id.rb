class ChangeProjectFunderToEmployeeId < ActiveRecord::Migration
  def up
    add_column :projects, :employee_id, :integer
    remove_column :projects, :funder
  end

  def down
    remove_column :projects, :employee_id, :integer
    add_column :projects, :funder
  end
end
