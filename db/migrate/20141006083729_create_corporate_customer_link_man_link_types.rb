class CreateCorporateCustomerLinkManLinkTypes < ActiveRecord::Migration
  def up
    create_table :corporate_customer_link_man_link_types do |t|
      t.string :name

      t.timestamps
    end
    CorporateCustomer::LinkMan::LinkType.reset_column_information
    Rake.application['db:import_data'].invoke('corporate_customer_link_man_link_types')
    change_table :corporate_customer_link_men do |t|
      t.references :corporate_customer_link_man_type
    end
    CorporateCustomer::LinkMan.reset_column_information
    id = CorporateCustomer::LinkMan::LinkType.first.id
    CorporateCustomer::LinkMan.all.each do |m|
      m.corporate_customer_link_man_type_id = id
      m.save
    end
  end
end
