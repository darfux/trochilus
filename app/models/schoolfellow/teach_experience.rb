class Schoolfellow::TeachExperience < ActiveRecord::Base
  belongs_to :schoolfellow
  belongs_to :teacher_title
  belongs_to :univ_unit

  after_destroy :check_schoolfellow
  def check_schoolfellow
    if schoolfellow.study_experiences.empty? && 
      schoolfellow.teach_experiences.empty?
      schoolfellow.destroy
    end
  end
  def college
    univ_unit
  end
  def title
    teacher_title.name
  end
end
