class CreateProjectLevels < ActiveRecord::Migration
  def change
    create_table :project_levels do |t|
      t.string :name

      t.timestamps
    end
  end
end
