class AddConclusionToContactRecord < ActiveRecord::Migration
  def change
    add_column :contact_records, :conclusion, :text
  end
end
