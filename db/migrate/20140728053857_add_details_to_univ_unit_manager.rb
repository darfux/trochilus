class AddDetailsToUnivUnitManager < ActiveRecord::Migration
  def change
    change_table :univ_unit_managers do |t|
      t.string :tel
      t.string :mobile
      t.string :email
      t.string :fax
      t.string :postcode
    end
  end
end
