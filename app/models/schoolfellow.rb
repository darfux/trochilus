class Schoolfellow < ActiveRecord::Base
  belongs_to :individual_customer
  has_many :study_experiences
  has_many :teach_experiences
end
