class CreateRegionStates < ActiveRecord::Migration
  def change
    create_table :region_states do |t|
      t.string :name
      t.string :code
      t.references :region_country, index: true

      t.timestamps
    end
  end
end
