class CreateDonationRecordActualFunds < ActiveRecord::Migration
  def change
    create_table :donation_record_actual_funds do |t|
      t.integer :donation_record_id
      t.integer :fund_id

      t.timestamps
    end
  end
end
