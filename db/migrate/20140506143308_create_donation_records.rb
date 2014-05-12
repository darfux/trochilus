class CreateDonationRecords < ActiveRecord::Migration
  def change
    create_table :donation_records do |t|
      t.integer :customer_project_id
      t.integer :employee_id
      t.integer :fund_id
      t.integer :donation_type_id

      t.timestamps
    end
  end
end
