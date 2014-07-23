class ContactRecord < ActiveRecord::Base
  belongs_to :customer
  belongs_to :creator, class_name: :User, foreign_key: :creator_id

  def creator!
    creator.user
  end
end
