class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.references :customer_type, index: true
      t.references :employee, index: true

      t.timestamps
    end
  end
end
