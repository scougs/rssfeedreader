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

  attr_accessible :bio, :email, :first_name, :last_name, :photo, :role, :password, :password_confirmation, :remember_me


  def get_feeds
    #binding.pry
  end

  def user_categories_and_feeds
    feed_users.includes(:feed).group_by(&:category)
  end

end
