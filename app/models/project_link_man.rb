class ProjectLinkMan < ActiveRecord::Base
  belongs_to :customer
  belongs_to :project

  validates_uniqueness_of :project_id,  scope: [:customer_id]
end
