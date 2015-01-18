class AddTimeToItemDonationRecord < ActiveRecord::Migration
  def change
    add_column :item_donation_records, :time, :datetime
  end
end
