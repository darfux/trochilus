class CreateIndividualCustomers < ActiveRecord::Migration
  def change
    create_table :individual_customers do |t|
      t.references :customer, index: true

      t.timestamps
    end
  end
end
