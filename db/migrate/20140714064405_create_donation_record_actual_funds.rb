class CreateDonationRecordActualFunds < ActiveRecord::Migration
  def change
    create_table :donation_record_actual_funds do |t|
      t.references :donation_record, index: true
      t.references :fund, index: true

      t.timestamps
    end
  end
end
