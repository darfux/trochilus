class CreateWxDonateForms < ActiveRecord::Migration
  def change
    create_table :wx_donate_forms do |t|
      t.string :donator
      t.integer :wx_donate_project_id
      t.integer :wx_donate_project_sub_id
      t.integer :amount
      t.boolean :gender
      t.string :email
      t.string :phone
      t.text :address
      t.string :postcode
      t.string :company
      t.string :nk_relation_id
      t.string :nk_relation_sub_id
      t.text :school_info
      t.text :message
      t.integer :need_cert
      t.integer :need_receipt
      t.string :out_trade_no
      t.boolean :notify_flag

      t.timestamps
    end
  end
end
