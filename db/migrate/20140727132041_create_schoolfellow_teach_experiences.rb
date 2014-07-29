class CreateSchoolfellowTeachExperiences < ActiveRecord::Migration
  def change
    create_table :schoolfellow_teach_experiences do |t|
      t.references :schoolfellow, index: true
      t.references :teacher_title, index: true
      t.references :univ_unit, index: true
      t.date :teach_start
      t.date :teach_end
      t.string :idnum

      t.timestamps
    end
  end
end
