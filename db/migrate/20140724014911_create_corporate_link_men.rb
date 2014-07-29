class CreateCorporateLinkMen < ActiveRecord::Migration
  def change
    create_table :corporate_link_men do |t|
      t.references :corporate_customer, index: true
      t.references :individual_customer, index: true
      t.text :comment

      t.timestamps
    end
  end
end
