class AddLocationToContactRecord < ActiveRecord::Migration
  def change
    add_column :contact_records, :location, :string
  end
end
