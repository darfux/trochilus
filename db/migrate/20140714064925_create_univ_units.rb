class CreateUnivUnits < ActiveRecord::Migration
  def change
    create_table :univ_units do |t|
      t.string :name

      t.timestamps
    end
  end
end
