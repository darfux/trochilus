class AddUsageCommentToUsageRecord < ActiveRecord::Migration
  def change
    add_column :usage_records, :usage_comment, :text
  end
end
