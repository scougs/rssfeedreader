class User < ActiveRecord::Base

  mount_uploader :photo, UserPhotoUploader

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :feed_users, :dependent => :destroy
  has_many :entry_users, :dependent => :destroy

  has_many :feeds, through: :feed_users

  has_many :entries, through: :entry_users

  attr_accessible :role, :bio, :email, :first_name, :last_name, :photo, :password, :password_confirmation, :remember_me

  before_validation :set_default_role

  def get_feeds

  end

  def role?(role)
    self.role == role
  end
  #Salman: user_categories and feeds was in private, messing up stuff.
   def user_categories_and_feeds
    feed_users.includes(:feed).group_by(&:category)
  end

  private
  def set_default_role
    self.role ||= "basic_user"
  end

end

