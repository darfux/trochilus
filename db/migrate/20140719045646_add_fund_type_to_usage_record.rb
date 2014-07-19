class AddFundTypeToUsageRecord < ActiveRecord::Migration
  def change
    add_column :usage_records, :fund_type_id, :integer, index: true
  end
end
