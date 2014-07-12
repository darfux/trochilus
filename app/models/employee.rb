class Employee < ActiveRecord::Base
  has_many :customers
  has_many :donation_records
  has_one :user, as: :user, dependent: :destroy, validate: true
  has_many :projects

  validates_presence_of :name
  def name_with_id
    "#{id}-#{name}"
  end
end
