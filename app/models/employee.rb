class Employee < ActiveRecord::Base
  include CommonUser
  acts_as_common_user

  has_many :created_customers, class_name: "Customer", foreign_key: "creator_id"
  has_many :donation_records

  has_many :projects

  validates_presence_of :name
  def name_with_id
    "#{id}-#{name}"
  end
end
