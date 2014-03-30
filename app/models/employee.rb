class Employee < ActiveRecord::Base

  def name_with_id
    "#{id}-#{name}"
  end
end
