class CreateUnivUnitManagers < ActiveRecord::Migration
  def change
    create_table :univ_unit_managers do |t|
      t.string :name
      t.references :univ_unit

      t.timestamps
    end
    add_index :univ_unit_managers, :univ_unit_id
  end
end
