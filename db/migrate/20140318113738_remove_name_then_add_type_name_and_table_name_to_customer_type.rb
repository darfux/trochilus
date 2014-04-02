class RemoveNameThenAddTypeNameAndTableNameToCustomerType < ActiveRecord::Migration
  def up
    add_column(:customer_types, :type_name, :string)
    add_column(:customer_types, :table_name, :string)
    remove_column(:customer_types, :name)
  end
  def down
    remove_column(:customer_types, :type_name)
    remove_column(:customer_types, :table_name)
    add_column(:customer_types, :name, :string)
  end
end
