class CreateOrgnizationCustomers < ActiveRecord::Migration
  def change
    create_table :orgnization_customers do |t|
      t.references :customer, index: true

      t.timestamps
    end
  end
end
