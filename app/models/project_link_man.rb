class ProjectLinkMan < ActiveRecord::Base
  belongs_to :customer
  belongs_to :project

  validates_uniqueness_of :customer_id,  scope: [:project_id]
end
