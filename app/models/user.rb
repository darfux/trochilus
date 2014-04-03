class User < ActiveRecord::Base
  belongs_to :customer, polymorphic: true, dependent: :destroy
  
  attr_accessible :account, :password, :password_confirmation, :user_id
  
  has_secure_password

  validates_presence_of :password, :password_confirmation # validate confirmation will not work if password_fonfirmation is nil! 
                                                          # Don't forget to check your patams permit in controller too.
  validates_confirmation_of :password
  validates :account, :presence => true, :uniqueness => true
  validates :password, :presence => true, :on => :create
end
