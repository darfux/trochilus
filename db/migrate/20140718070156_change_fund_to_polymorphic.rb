class ChangeFundToPolymorphic < ActiveRecord::Migration
  def change
    remove_column :funds, :fund_type_id
    add_column :funds, :fund_instance_type, :string, index: true
    add_column :funds, :fund_instance_id, :integer, index: true

    remove_column :donation_record_actual_funds, :fund_id
    remove_column :donation_records, :plan_fund_id
    remove_column :usage_records, :fund_id
  end
end
