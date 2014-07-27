class CreateUsageRecordUsedFunds < ActiveRecord::Migration
  def change
    create_table :usage_record_used_funds do |t|
      t.references :usage_record, index: true
      t.references :fund_type, index: true

      t.timestamps
    end
  end
end
