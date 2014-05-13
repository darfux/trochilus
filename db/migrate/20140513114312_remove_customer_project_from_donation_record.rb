class RemoveCustomerProjectFromDonationRecord < ActiveRecord::Migration
  def up
    remove_column(:donation_records, :customer_project_id)
  end

  def down
    add_column(:donation_records, :customer_project_id, :integer)
  end
end
