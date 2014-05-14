class AddCurrencyIdAndOriginAmountToFund < ActiveRecord::Migration
  def up
    add_column :funds, :currency_id, :integer
    add_column :funds, :origin_amount, :decimal
  end
  def down
    remove_column :funds, :currency_id
    remove_column :funds, :origin_amount
  end
end
