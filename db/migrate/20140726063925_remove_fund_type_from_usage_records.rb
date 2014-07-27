class RemoveFundTypeFromUsageRecords < ActiveRecord::Migration
  def change
    remove_column :usage_records, :fund_type_id, :integer, index: true
  end
end
