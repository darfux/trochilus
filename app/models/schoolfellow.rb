class Schoolfellow < ActiveRecord::Base
  belongs_to :individual_customer
  has_many :univ_experiences
  accepts_nested_attributes_for :univ_experiences
end
