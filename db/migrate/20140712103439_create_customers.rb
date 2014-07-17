class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.references :customer, index: true
      t.string :customer_type

      t.timestamps
    end
  end
end
