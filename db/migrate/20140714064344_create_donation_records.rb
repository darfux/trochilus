class CreateDonationRecords < ActiveRecord::Migration
  def change
    create_table :donation_records do |t|
      t.references :customer, index: true
      t.references :project, index: true
      t.references :creator, index: true
      t.references :plan_fund, index: true
      t.references :donation_type, index: true

      t.timestamps
    end
  end
end
