class CreateUndeterminedFunds < ActiveRecord::Migration
  def change
    create_table :undetermined_funds do |t|

      t.timestamps
    end
  end
end
