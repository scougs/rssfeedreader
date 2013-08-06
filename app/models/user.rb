class User < ActiveRecord::Base

  mount_uploader :photo, UserPhotoUploader

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :feed_users

  has_many :feeds, through: :feed_users

  has_many :entries, through: :entry_user

  attr_accessible :role, :bio, :email, :first_name, :last_name, :photo, :password, :password_confirmation, :remember_me

  before_validation :set_default_role

  def get_feeds

  end

  def role?(role)
    self.role == role
  end


  private
  def set_default_role
    self.role ||= "basic_user"
  end
end

