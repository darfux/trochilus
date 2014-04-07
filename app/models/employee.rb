class Employee < ActiveRecord::Base
  #see http://guides.rubyonrails.org/association_basics.html#options-for-has-one-validate 
  has_one :user, as: :user, dependent: :destroy, validate: true

  attr_accessible :name
  validates_presence_of :name
  def name_with_id
    "#{id}-#{name}"
  end
end
