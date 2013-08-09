
class Entry < ActiveRecord::Base

  include ActionView::Helpers::SanitizeHelper

  belongs_to :feed
  # Besure to always destory, not delete to call this.
  has_many :entry_users, :dependent => :destroy

  has_many :users, through: :entry_users

  validates :url, :uniqueness => {:scope => :guid}
   validates_presence_of :url
    validates_presence_of :feed_id
  attr_accessible :author, :categories, :content, :feed_id, :published, :summary, :title, :url, :guid

  def reading_time

    html = self.content
    words = sanitize(html).split.size
    time = (words/200)*60

    minutes = (time/60).to_i
    seconds = (time % 60).to_i

    if minutes == 0
      return "less than a minute"
    elsif seconds > 45
      return "almost #{minutes+1} minutes"
    elseif minutes == 1
      return "about a minute"
    else
      return "almost #{minutes} minutes"
    end

  end

end