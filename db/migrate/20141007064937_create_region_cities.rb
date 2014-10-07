class CreateRegionCities < ActiveRecord::Migration
  def change
    create_table :region_cities do |t|
      t.string :name
      t.string :code
      t.references :region_state, index: true

      t.timestamps
    end
  end
end
