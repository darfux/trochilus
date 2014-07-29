class Schoolfellow::StudyExperience < ActiveRecord::Base
  belongs_to :schoolfellow
  belongs_to :major
  belongs_to :degree

  after_destroy :check_schoolfellow
  def check_schoolfellow
    if schoolfellow.study_experiences.empty? && 
      schoolfellow.teach_experiences.empty?
      schoolfellow.destroy
    end
  end
  def college
    major.univ_unit
  end
end
