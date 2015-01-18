class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :name_abbrpy
      t.integer :amount
      t.decimal :price
      t.text :comment
      t.references :item_donation_record, index: true
      t.references :item_category, index: true

      t.timestamps
    end
  end
end
