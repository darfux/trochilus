class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.references :univ_unit, index: true

      t.timestamps
    end
  end
end
