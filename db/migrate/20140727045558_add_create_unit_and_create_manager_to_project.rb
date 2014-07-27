class AddCreateUnitAndCreateManagerToProject < ActiveRecord::Migration
  def change
    add_column :projects, :create_unit_id, :integer, index: true
    add_column :projects, :create_manager_id, :integer, index: true
  end
end
