class Project::News < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :title
  validates_presence_of :link
end
