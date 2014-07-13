class CreateContactRecords < ActiveRecord::Migration
  def change
    create_table :contact_records do |t|
      t.references :customer, index: true
      t.references :employee, index: true
      t.datetime :time
      t.text :description

      t.timestamps
    end
  end
end
