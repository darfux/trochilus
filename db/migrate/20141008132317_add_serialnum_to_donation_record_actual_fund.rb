class AddSerialnumToDonationRecordActualFund < ActiveRecord::Migration
  def change
    add_column :donation_record_actual_funds, :serialnum, :string
    add_index :donation_record_actual_funds, :serialnum
  end
end
