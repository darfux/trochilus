class ProjectType < ActiveRecord::Base
  attr_accessible :name
  has_many :project_type
end
