class Feed < ActiveRecord::Base
  has_many :feed_users
  has_many :entries
  has_many :users, through: :feed_users

  validates_uniqueness_of :title

  attr_accessible :etag, :feed_url, :last_modified, :title, :url

  def self.create_feed(url)
    return RSSReader.create_rss_feed(url)
  end
  
end
