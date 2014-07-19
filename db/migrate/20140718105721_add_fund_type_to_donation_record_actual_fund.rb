class AddFundTypeToDonationRecordActualFund < ActiveRecord::Migration
  def change
    add_column :donation_record_actual_funds, :fund_type_id, :integer, index: true
  end
end
