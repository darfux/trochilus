class CreateSchoolfellows < ActiveRecord::Migration
  def change
    create_table :schoolfellows do |t|
      t.references :individual_customer, index: true

      t.timestamps
    end
  end
end
