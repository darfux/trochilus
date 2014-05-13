class AddProjectAndCustomerToDonationRecord < ActiveRecord::Migration
  def up
    add_column(:donation_records, :customer_id, :integer)
    add_column(:donation_records, :project_id, :integer)
  end
  def down
    remove_column(:donation_records, :customer_id)
    remove_column(:donation_records, :project_id)
  end
end
