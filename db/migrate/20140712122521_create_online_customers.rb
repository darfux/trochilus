class CreateOnlineCustomers < ActiveRecord::Migration
  def change
    create_table :online_customers do |t|

      t.timestamps
    end
  end
end
