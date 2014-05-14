class RenameFundIdToPlanFundIdInDonationRecord < ActiveRecord::Migration
  def up
    rename_column :donation_records, :fund_id, :plan_fund_id
  end

  def down
    rename_column :donation_records, :plan_fund_id, :fund_id
  end
end
