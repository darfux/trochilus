class CreateCorporateCustomerLinkManLinkTypes < ActiveRecord::Migration
  def up
    create_table :corporate_customer_link_man_link_types do |t|
      t.string :name

      t.timestamps
    end
    #http://stackoverflow.com/questions/577944/how-to-run-rake-tasks-from-within-rake-tasks
    #This first resets the task's already_invoked state, allowing the task to then be executed again, dependencies and all
    Rake.application["db:import_data"].reenable
    Rake.application["db:import_data"].invoke('corporate_customer_link_man_link_types')
    change_table :corporate_customer_link_men do |t|
      t.references :corporate_customer_link_man_link_type
    end
    CorporateCustomer::LinkMan.reset_column_information
    id = CorporateCustomer::LinkMan::LinkType.all.reload.first.id #the reload is nessary when in production
    CorporateCustomer::LinkMan.all.each do |m|
      m.corporate_customer_link_man_link_type_id ||= id
      m.save
    end
  end
end
