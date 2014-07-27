class CreateSchoolfellowStudyExperiences < ActiveRecord::Migration
  def change
    create_table :schoolfellow_study_experiences do |t|
      t.references :schoolfellow, index: true
      t.references :major, index: true
      t.references :degree, index: true
      t.date :attendance_date
      t.date :graduated_date
      t.string :student_number

      t.timestamps
    end
  end
end
