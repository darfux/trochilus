class ChangeCustomersToPolymorphic < ActiveRecord::Migration
  def up
    add_column :customers, :customer_id, :integer    
    add_column :customers, :customer_type, :string
    remove_column :customers, :customer_type_id, :integer
    remove_column :corporate_customers, :customer_id, :integer
    remove_column :individual_customers, :customer_id, :integer
    remove_column :orgnization_customers, :customer_id, :integer
    remove_column :online_customers, :customer_id, :integer
  end
  def down
    remove_column :customers, :customer_id, :integer
    remove_column :customers, :customer_type, :string
    add_column :customers, :customer_type_id, :integer
    add_column :corporate_customers, :customer_id, :integer
    add_column :individual_customers, :customer_id, :integer
    add_column :orgnization_customers, :customer_id, :integer
    add_column :online_customers, :customer_id, :integer
  end
end
