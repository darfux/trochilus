class CreateCorporateCustomers < ActiveRecord::Migration
  def change
    create_table :corporate_customers do |t|

      t.timestamps
    end
  end
end
