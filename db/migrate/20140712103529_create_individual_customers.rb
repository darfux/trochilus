class CreateIndividualCustomers < ActiveRecord::Migration
  def change
    create_table :individual_customers do |t|

      t.timestamps
    end
  end
end
