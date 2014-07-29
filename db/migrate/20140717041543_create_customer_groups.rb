class CreateCustomerGroups < ActiveRecord::Migration
  def change
    create_table :customer_groups do |t|

      t.timestamps
    end
  end
end
