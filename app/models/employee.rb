class Employee < ActiveRecord::Base
  include CommonUser
  acts_as_common_user

  validates_presence_of :name
  def name_with_id
    "#{id}-#{name}"
  end
end
