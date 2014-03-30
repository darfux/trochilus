class Project < ActiveRecord::Base
  belongs_to :project_level
  belongs_to :project_state
end
