class Project < ActiveRecord::Base
  belongs_to :project_level
  belongs_to :project_state
  belongs_to :project_type
  belongs_to :employee
  attr_accessible :name, :serialnum, :create_date, :employee_id, :brief, 
  	:gross, :balance, :endowment, :project_level_id, :project_state_id, :project_type_id
end
