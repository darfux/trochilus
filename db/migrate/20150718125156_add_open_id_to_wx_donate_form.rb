class AddOpenIdToWxDonateForm < ActiveRecord::Migration
  def change
    add_column :wx_donate_forms, :openid, :string
  end
end
