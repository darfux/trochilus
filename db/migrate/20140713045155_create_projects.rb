class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :serialnum
      t.date :create_date
      t.references :employee, index: true
      t.text :brief
      t.boolean :endowment
      t.references :project_level, index: true
      t.references :project_state, index: true
      t.references :project_type, index: true

      t.timestamps
    end
  end
end
