class AddCommentToAProAUsRaCus < ActiveRecord::Migration
  def change
    add_column :projects, :comment, :text
    add_column :usage_records, :comment, :text
    add_column :customers, :comment, :text
  end
end
