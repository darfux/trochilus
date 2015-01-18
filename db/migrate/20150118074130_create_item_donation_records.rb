class CreateItemDonationRecords < ActiveRecord::Migration
  def change
    create_table :item_donation_records do |t|
      t.references :customer, index: true
      t.references :project, index: true
      t.references :creator, index: true

      t.timestamps
    end
  end
end
