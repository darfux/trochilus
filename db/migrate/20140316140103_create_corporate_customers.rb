class CreateCorporateCustomers < ActiveRecord::Migration
  def change
    create_table :corporate_customers do |t|
      t.references :customer, index: true

      t.timestamps
    end
  end
end
