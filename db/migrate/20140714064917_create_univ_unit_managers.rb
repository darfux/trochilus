class CreateUnivUnitManagers < ActiveRecord::Migration
  def change
    create_table :univ_unit_managers do |t|
      t.string :name
      t.references :univ_unit, index: true

      t.timestamps
    end
  end
end
