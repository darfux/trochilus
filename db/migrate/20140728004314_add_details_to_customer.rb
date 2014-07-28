class AddDetailsToCustomer < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.string :country
      t.string :province
      t.string :city
      t.string :address
      t.string :tel
      t.string :email
      t.string :fax
      t.string :postcode
    end
    change_table :individual_customers do |t|
      t.boolean :gender
      t.string :nation
      t.string :native_place
      t.date :birthday
      t.references :corporate_customer, index: true
      t.string :title
    end
  end
end
