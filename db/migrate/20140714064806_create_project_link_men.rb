class CreateProjectLinkMen < ActiveRecord::Migration
  def change
    create_table :project_link_men do |t|
      t.references :customer, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
