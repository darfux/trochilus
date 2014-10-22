class CreateRegionCountries < ActiveRecord::Migration
  def change
    create_table :region_countries do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
