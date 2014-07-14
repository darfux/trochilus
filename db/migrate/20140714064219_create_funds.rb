class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.decimal :amount
      t.datetime :time
      t.references :fund_type, index: true
      t.text :comment
      t.references :currency, index: true
      t.decimal :origin_amount

      t.timestamps
    end
  end
end
