class Customer < ActiveRecord::Base
  belongs_to :customer, polymorphic: true, dependent: :destroy
  # belongs_to :customer_type
  belongs_to :employee
  attr_accessible :name, :employee_id
  def customer_type
    super
  end
  def to_s
    name
  end
end