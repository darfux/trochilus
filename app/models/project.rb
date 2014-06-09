class Project < ActiveRecord::Base
  belongs_to :project_level
  belongs_to :project_state
  belongs_to :project_type
  belongs_to :employee

  has_many :project_link_men
  has_many :link_men, class_name: :Customer, through: :project_link_men, source: :customer
  has_many :donation_records
  has_many :usage_records

  validates_associated :link_men
  validates_associated :project_link_men
end