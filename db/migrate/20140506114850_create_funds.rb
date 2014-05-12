class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.decimal :amount
      t.datetime :time
      t.references :fund_type
      t.text :comment

      t.timestamps
    end
    add_index :funds, :fund_type_id
  end
end
