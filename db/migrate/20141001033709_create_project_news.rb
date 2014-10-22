class CreateProjectNews < ActiveRecord::Migration
  def change
    create_table :project_news do |t|
      t.string :title
      t.text :link
      t.text :comment
      t.references :project, index: true

      t.timestamps
    end
  end
end
