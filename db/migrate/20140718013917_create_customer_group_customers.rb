class CreateCustomerGroupCustomers < ActiveRecord::Migration
  def change
    create_table :customer_group_customers do |t|
      t.references :customer, index: true
      t.references :customer_group, index: true

      t.timestamps
    end
  end
end
