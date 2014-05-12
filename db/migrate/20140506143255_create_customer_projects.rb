class CreateCustomerProjects < ActiveRecord::Migration
  def change
    create_table :customer_projects do |t|
      t.integer :customer_id
      t.integer :project_id

      t.timestamps
    end
  end
end
