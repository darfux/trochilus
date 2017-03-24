class CreateProjectNecessaryDates < ActiveRecord::Migration
  def change
    create_table :project_necessary_dates do |t|
      t.date :date
      t.string :comment
      t.references :project, index: true

      t.timestamps
    end
  end
end
