class AddColumnProjectTypeToProject < ActiveRecord::Migration
  def up
    add_column :projects, :project_type_id, :integer
  end
  def down
    remove_column :projects, :project_type_id
  end
end
