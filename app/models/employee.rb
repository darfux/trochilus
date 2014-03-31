class Employee < ActiveRecord::Base
  attr_accessible :name
  def name_with_id
    "#{id}-#{name}"
  end
end
