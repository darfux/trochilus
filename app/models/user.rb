class User < ActiveRecord::Base
  include PolymorphicExtension
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :user, polymorphic: true
  validates :account, uniqueness: true, presence: true

  protected

    def email_required?
      false
    end
end
