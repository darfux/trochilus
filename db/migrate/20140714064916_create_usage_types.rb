class CreateUsageTypes < ActiveRecord::Migration
  def change
    create_table :usage_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
