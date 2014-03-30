class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :cotent
      t.datetime :time
      t.integer :counter
      t.references :channel, index: true

      t.timestamps
    end
  end
end
