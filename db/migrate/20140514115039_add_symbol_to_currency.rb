class AddSymbolToCurrency < ActiveRecord::Migration
  def up
    add_column :currencies, :symbol, :string
  end  
  def down
    remove_column :currencies, :symbol
  end
end
