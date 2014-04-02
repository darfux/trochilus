class Employee < ActiveRecord::Base
  has_one :user, as: :user, dependent: :destroy

  attr_accessible :name
  validates_presence_of :name
  def name_with_id
    "#{id}-#{name}"
  end
end
