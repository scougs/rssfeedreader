class FeedUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :feed

  validates_presence_of :user_id
  validates_presence_of :feed_id

  # Checks for uniquness, in a pair for (user_id, feed_id)
  validates :user_id, :uniqueness => {:scope => :feed_id}

  attr_accessible :feed_id, :private, :tag, :user_id, :category


  def self.hash_by_category(userfeeds)
    hash_userfeeds ={}
    userfeeds.each do |userfeed|
        hash_userfeeds[userfeed.category] = hash_userfeeds[userfeed.category].to_a
        hash_userfeeds[userfeed.category].push(userfeed)
        binding.pry if DEBUG
    end
    return hash_userfeeds
  end
end
