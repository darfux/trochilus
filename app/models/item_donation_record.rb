class ItemDonationRecord < ActiveRecord::Base
  belongs_to :customer
  belongs_to :project
  belongs_to :creator, class_name: :User, foreign_key: :creator_id

  has_many :items, validate: true, dependent: :destroy
  has_many :attachments, as: :attachment_owner, validate: true, dependent: :destroy

  validates_presence_of :customer
  validates_presence_of :project
  # accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true

  def total_price
    price = 0
    items.each do |item|
      price += item.price if item.price
    end
    price
  end
end
