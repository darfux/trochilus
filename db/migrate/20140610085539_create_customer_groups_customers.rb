class CreateCustomerGroupsCustomers < ActiveRecord::Migration
  def change
    create_table :customer_groups_customers do |t|
      t.references :customer
      t.references :customer_group
    end
    add_index :customer_groups_customers, :customer_id
    add_index :customer_groups_customers, :customer_group_id
  end
end
