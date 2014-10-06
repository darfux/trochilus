class CreateDonationRecordInterestPeriods < ActiveRecord::Migration
  def change
    create_table :donation_record_interest_periods do |t|
      t.decimal :rate
      t.date :start
      t.date :end
      t.text :comment
      t.references :donation_record, index: true

      t.timestamps
    end
  end
end
