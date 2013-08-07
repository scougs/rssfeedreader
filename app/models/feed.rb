class Feed < ActiveRecord::Base
  has_many :feed_users, :dependent => :destroy
  has_many :entries, :dependent => :destroy

  has_many :users, through: :feed_users


  # TODO: Validate scope with guid, rather then just title
  validates_uniqueness_of :title


  attr_accessible :etag, :feed_url, :last_modified, :title, :url

  def self.create_feed(url)
    return RSSReader.create_rss_feed(url)
  end

end
