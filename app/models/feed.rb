class Feed < ActiveRecord::Base
  has_many :feed_users, :dependent => :destroy
  has_many :entries, :dependent => :destroy

  has_many :users, through: :feed_users


  # TODO: Validate scope with guid, rather then just title
   validates_presence_of :feed_url
  validates_uniqueness_of :title


  attr_accessible :etag, :feed_url, :last_modified, :title, :url

@arr =['http://1000awesomethings.com',
    'http://blog.joerogan.net',
    'http://www.hongkiat.com/blog',
    'http://blogs.telegraph.co.uk/',
    'http://wordpress.bytesforall.com/',
    'http://www.devlounge.net/',
    'http://hosted.ap.org/lineups/USHEADS-rss_2.0.xml?SITE=RANDOM&SECTION=HOME',
    'http://rssfeeds.usatoday.com/usatoday-NewsTopStories',
  'http://1000awesomethings.com',
    'http://blog.joerogan.net',
    'http://www.hongkiat.com/blog',
    'http://blogs.telegraph.co.uk/',
    'http://wordpress.bytesforall.com/',
    'http://www.devlounge.net/',
    'http://hosted.ap.org/lineups/USHEADS-rss_2.0.xml?SITE=RANDOM&SECTION=HOME',
    'http://rssfeeds.usatoday.com/usatoday-NewsTopStories',
  'http://1000awesomethings.com',
    'http://blog.joerogan.net',
    'http://www.hongkiat.com/blog',
    'http://blogs.telegraph.co.uk/',
    'http://wordpress.bytesforall.com/',
    'http://www.devlounge.net/',
    'http://hosted.ap.org/lineups/USHEADS-rss_2.0.xml?SITE=RANDOM&SECTION=HOME',
    'http://rssfeeds.usatoday.com/usatoday-NewsTopStories']

  def self.create_feed(url)
    return RSSReader.new.create_rss_feed(url)
  end

  def self.test_create_feed
    arr.each do |link|
      RSSReader.new.create_rss_feed(link)
    end
  end

  def self.links
    return @arr
  end

  def self.thread_create(url,category, user_id)
    # Thread.new do
        # Fix make sure i can find by a parsed url
        # Todo: Check if the xml url is available rather then homepage.

        @feed = Feed.where('url = :url OR feed_url = :url', url: url).first
        @user = User.find(user_id)
        if (@feed == nil)
          @feed = RSSReader.new.create_rss_feed(url)
           if(@feed != nil)
            @feed.save
          else
            return nil
          end
        end
        binding.pry if DEBUG
        attributes = {
          feed_id: @feed.id,
          user_id: @user.id,
          category: (category.capitalize)
        }
        @feed.entries.each do |entry|
            entryuser=EntryUser.create(user_id: user_id, entry_id: entry.id, feed_id: @feed.id)
        end
        FeedUser.create(attributes)
        ActiveRecord::Base.connection.close
      # end
  end
  # TODO: What to do with this ?
  def get_read_user_entries(user)
    array = []
    user.entry_users.each do |entryuser|
      self.entries.each do |entry|
        if(entryuser.entry_id ==entry.id &&
           entryuser.read == true )
              array.push(entryuser)
        end
      end
    end
    return array;
  end
end
