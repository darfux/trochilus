class User < ActiveRecord::Base
  include PolymorphicExtension
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :user, polymorphic: true
  validates :account, uniqueness: true, presence: true

  has_many :created_customers, class_name: "Customer", foreign_key: :creator_id
  has_many :created_projects, class_name: "Project", foreign_key: :creator_id
  has_many :donation_records
  has_many :usage_records
  
  set_accessable_attributes [:created_customers, :created_projects]
  protected

    def email_required?
      false
    end
end
