class CreateDonationTypes < ActiveRecord::Migration
  def change
    create_table :donation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
