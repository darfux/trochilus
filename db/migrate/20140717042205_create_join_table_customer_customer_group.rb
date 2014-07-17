class CreateJoinTableCustomerCustomerGroup < ActiveRecord::Migration
  def change
    create_join_table :customers, :customer_groups do |t|
      # t.index [:customer_id, :customer_group_id]
      # t.index [:customer_group_id, :customer_id]
      t.index :customer_group_id
      t.index :customer_id
    end
  end
end
