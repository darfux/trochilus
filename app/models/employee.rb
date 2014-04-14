class Employee < ActiveRecord::Base
  #see http://guides.rubyonrails.org/association_basics.html#options-for-has-one-validate
  has_many :customers
  has_one :user, as: :user, dependent: :destroy, validate: true
  has_many :project

  attr_accessible :name, :account
  validates_presence_of :name
  def name_with_id
    "#{id}-#{name}"
  end
end
