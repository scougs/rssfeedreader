class FeedUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :feed

  attr_accessible :feed_id, :private, :tag, :user_id, :category


end
