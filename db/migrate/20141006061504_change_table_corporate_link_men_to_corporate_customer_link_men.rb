class ChangeTableCorporateLinkMenToCorporateCustomerLinkMen < ActiveRecord::Migration
  def change
    rename_table :corporate_link_men, :corporate_customer_link_men
  end
end
