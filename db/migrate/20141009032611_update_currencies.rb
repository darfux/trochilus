class UpdateCurrencies < ActiveRecord::Migration
  def up
    Currency.destroy_all
    Rake.application["db:import_data"].reenable
    Rake.application["db:import_data"].invoke('currencies')
  end
end
